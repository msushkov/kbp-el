#! /usr/bin/env python

"""
Extractor for relation mention features.

Outputs 2 feature for each relation mention:
  - the dependency path between the mentions
  - the presence of the words "wife", "widow", or "husband" along the dependency path
    (this should help with the spouse relation)

(refer to http://www.stanford.edu/~jurafsky/mintz.pdf)

Input query:

        SELECT s.doc_id AS doc_id,
               s.sentence_id AS sentence_id,
               array_to_string(max(s.lemma), '~^~') AS lemma,
               array_to_string(max(s.dep_graph), '~^~') AS dep_graph,
               array_to_string(max(s.words), '~^~') AS words,
               array_to_string(array_accum(m.mention_id), '~^~') AS mention_ids,
               array_to_string(array_accum(m.word), '~^~') AS mention_words,
               array_to_string(array_accum(m.type), '~^~') AS types,
               array_to_string(array_accum(m.start_pos), '~^~') AS starts,
               array_to_string(array_accum(m.end_pos), '~^~') AS ends
        FROM sentence s,
             mentions m
        WHERE s.doc_id = m.doc_id AND
              s.sentence_id = m.sentence_id
        GROUP BY s.doc_id,
                 s.sentence_id
"""

import sys, json
from lib import dd as ddlib

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'


def dep_format_parser(dep_edge_str):
  """
  Given a string representing a dependency edge, return a tuple of
     (parent_index, edge_label, child_index).

  Args: dep_edge_str - a string representation of an edge in the dependency tree
             (e.g. "31 prep_of 33")
  Returns: tuple of (integer, string, integer) (e.g. (30, "prep_of", 32))
  """
  parent, label, child = dep_edge_str.split()
  return (int(parent) - 1, label, int(child) - 1) # input edge used 1-based indexing       


for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (doc_id, sentence_id, lemma_str, dep_graph_str, words_str, mention_ids_str, \
    mention_words_str, types_str, starts_str, ends_str) = row.strip().split('\t')

  # skip sentences with empty dependency graphs
  if dep_graph_str == "":
    continue

  lemma = lemma_str.split(ARR_DELIM)
  dep_graph = dep_graph_str.split(ARR_DELIM)
  words = words_str.split(ARR_DELIM)
  mention_ids = mention_ids_str.split(ARR_DELIM)
  mention_words = mention_words_str.split(ARR_DELIM)
  types = types_str.split(ARR_DELIM)
  starts = starts_str.split(ARR_DELIM)
  ends = ends_str.split(ARR_DELIM)

  # create a list of mentions
  mentions = zip(mention_ids, mention_words, types, starts, ends)
  mentions = map(lambda x: {"mention_id" : x[0], "word" : x[1], "type" : x[2], "start" : int(x[3]), "end" : int(x[4])}, mentions)

  # don't output features for sentences that are too long
  if len(mentions) > 20 or len(lemma) > 100:
    continue

  # get a list of Word objects
  obj = {}
  obj['lemma'] = lemma
  obj['words'] = words
  obj['dep_graph'] = dep_graph
  word_obj_list = ddlib.unpack_words(obj, lemma='lemma', words='words', dep_graph='dep_graph', \
    dep_graph_parser=dep_format_parser)

  # at this point we have a list of the mentions in this sentence

  # go through all pairs of mentions
  for m1 in mentions:
    # make sure that the first mention is a PER or ORG
    if m1["type"] not in ["PERSON", "ORGANIZATION"]:
      continue

    for m2 in mentions:
      if m1["mention_id"] == m2["mention_id"]:
        continue

      # the features we will extract from this mention pair
      features = []

      # get the list of edges that constitute the dependency path between the mentions
      edges = ddlib.dep_path_between_words(word_obj_list, m1["end"] - 1, m2["end"] - 1)

      if len(edges) > 0:
        num_roots = 0 # the number of root nodes
        num_left = 0 # the number of edges to the left of the root
        num_right = 0 # the number of edges to the right of the root
        left_path = "" # the dependency path to the left of the root
        right_path = "" # the dependency path to the right of the root

        # find the index of the switch from up to down
        switch_direction_index = -1
        for i in range(len(edges)):
          if not edges[i].is_bottom_up:
            switch_direction_index = i
            break
        
        # iterate through the edge list
        for i in range(len(edges)):
          curr_edge = edges[i]

          # count the number of roots; if there are more than 1 root then our dependency
          # path is disconnected
          if curr_edge.label == 'ROOT':
            num_roots += 1

          # going from the left to the root
          if curr_edge.is_bottom_up:
            num_left += 1

            # if this is the edge pointing to the root (word2 is the root)
            if i == switch_direction_index - 1:
              left_path = left_path + ("--" + curr_edge.label + "->")
              root = curr_edge.word2.lemma.lower()

            # this edge does not point to the root
            else:
              # if we are at the last edge, don't include the word (part of the mention)
              if i == len(edges) - 1:
                left_path = left_path + ("--" + curr_edge.label + "->")
              else:
                left_path = left_path + ("--" + curr_edge.label + "->" + curr_edge.word2.lemma.lower())
          
          # going from the root to the right
          else:
            num_right += 1

            # the first edge to the right of the root
            if i == switch_direction_index:
              right_path = right_path + "<-" + curr_edge.label + "--"

            # this edge does not point from the root
            else:
              # if we are at the first edge, don't include the word (part of the mention)
              if i == 0:
                right_path = right_path + ("<-" + curr_edge.label + "--")
              else:
                # word1 is the parent for right to left
                right_path = right_path + (curr_edge.word1.lemma.lower() + "<-" + curr_edge.label + "--")
        
        # if the root is at the end or at the beginning (direction was all up or all down)
        if num_right == 0:
          root = "|SAMEPATH"
        elif num_left == 0:
          root = "SAMEPATH|"

        # if the edges have a disconnect (if there is more than 1 root)
        elif num_roots > 1:
          root = "|NONEROOT|"

        # this is a normal tree with a connected root in the middle
        else:
          root = "|" + root + "|"

        # reconstruct the dependency path
        path = left_path + root + right_path

        # doc_id, mid1, mid2, word1, word2, feature, type1, type2
        features.append([doc_id, m1["mention_id"], m2["mention_id"], m1["word"], m2["word"], path, m1["type"], m2["type"]])

        if 'wife' in path or 'widow' in path or 'husband' in path:
          feature = 'LEN_%d_wife/widow/husband' % (num_left + num_right)
          
          # doc_id, mid1, mid2, word1, word2, feature, type1, type2
          features.append([doc_id, m1["mention_id"], m2["mention_id"], m1["word"], m2["word"], feature, m1["type"], m2["type"]])

      # output all the features for this mention pair
      for feat in features:
        # make sure each of the strings we will output is encoded as utf-8
        map(lambda x: x.decode('utf-8', 'ignore'), feat)

        print "\t".join(feat)

