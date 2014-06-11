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

import sys, json, re

IGNORE_TYPE = {"URL": 1, "NUMBER" : 1, "MISC" : 1, "CAUSE_OF_DEATH":1, "CRIMINAL_CHARGE":1, 
    "DURATION":1, "MONEY":1, "ORDINAL" :1, "RELIGION":1, "SET": 1, "TIME":1}

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'    

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


  deptree = {}

  r = {}
  try:
    for edge in dep_graph:
      edge = re.sub('\s+', ' ', edge)
      (parent, label, child) = edge.split(' ') 
      deptree[int(child)-1] = {"label":label, "parent":int(parent)-1}
      r[int(parent)-1] = 1
  except:
    WHY55555555 = True
  if len(r) == 1:
    deptree = {}
    xw

  # at this point we have a list of the mentions in this sentence
  prefix = ""
  start1 = ""
  start2 = ""
  end1 = ""
  end2 = ""
  actstart = ""
  actend = ""
  feature = ""
  for m1 in mentions:
    start1 = m1["start"]
    end1 = m1["end"]

    if m1["type"] not in ["PERSON", "ORGANIZATION"]:
      continue

    for m2 in mentions:
      if m1["mention_id"] == m2["mention_id"]:
        continue

      features = []
      start2 = m2["start"]
      end2 = m2["end"]

      if len(deptree) > 0:
        path1 = []
        end = end1 - 1
        ct = 0
        while True:
          ct = ct + 1
          if ct > 100:
            break
          if end not in deptree:
            path1.append({"current":end, "parent": -1, "label":"ROOT"})
            break
          path1.append({"current":end, "parent": deptree[end]["parent"], "label":deptree[end]["label"]})
          end = deptree[end]["parent"]

        path2 = []
        end = end2 - 1
        ct = 0
        while True:
          ct = ct + 1
          if ct > 100:
            break
          if end not in deptree:
            path2.append({"current":end, "parent": -1, "label":"ROOT"})
            break
          path2.append({"current":end, "parent": deptree[end]["parent"], "label":deptree[end]["label"]})
          end = deptree[end]["parent"]

        commonroot = None
        for i in range(0, len(path1)):
          j = len(path1) - 1 - i
          if -i-1 <= -len(path2) or path1[j]["current"] != path2[-i-1]["current"]:
            break
          commonroot = path1[j]["current"]

        left_path = ""
        lct = 0
        for i in range(0, len(path1)):
          lct = lct + 1
          if path1[i]["current"] == commonroot:
            break
          if path1[i]["parent"] == commonroot or path1[i]["parent"]==-1:
            left_path = left_path + ("--" + path1[i]["label"] + "->" + '|')
          else:
            w = lemma[path1[i]["parent"]].lower()
            if i == 0: 
              w = ""
            left_path = left_path + ("--" + path1[i]["label"] + "->" + w)

        right_path = ""
        rct = 0
        for i in range(0, len(path2)):
          rct = rct + 1
          if path2[i]["current"] == commonroot:
            break
          if path2[i]["parent"] == commonroot or path2[i]["parent"]==-1:
            right_path = ('|' + "<-" + path2[i]["label"] + "--") + right_path
          else:
            w = lemma[path2[i]["parent"]].lower()
            if i == 0:
              w = ""
            right_path = (w + "<-" + path2[i]["label"] + "--" ) + right_path

        path = ""
        if commonroot == end1-1 or commonroot == end2-1:
          path = left_path + "SAMEPATH" + right_path
        else:
          if commonroot != None:
            path = left_path + lemma[commonroot].lower() + right_path
          else:
            path = left_path + "NONEROOT" + right_path

        if path != "":
          # doc_id, mid1, mid2, word1, word2, feature, type1, type2
          features.append([doc_id, m1["mention_id"], m2["mention_id"], m1["word"], m2["word"], path, m1["type"], m2["type"]])


        if 'wife' in path or 'widow' in path or 'husband' in path:
          feature = 'LEN_%d_wife/widow/husband' % (lct + rct)
  
          # doc_id, mid1, mid2, word1, word2, feature, type1, type2
          features.append([doc_id, m1["mention_id"], m2["mention_id"], m1["word"], m2["word"], feature, m1["type"], m2["type"]])

          
      # output all the features for this mention pair
      for feat in features:
        # make sure each of the strings we will output is encoded as utf-8
        map(lambda x: x.decode('utf-8', 'ignore'), feat)

        print "\t".join(feat)

  