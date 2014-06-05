#! /usr/bin/env python

"""
Extractor for the word sequence relation mention feature.

Outputs 1 feature for each relation mention:
  - the word sequence between the 2 mentions


Input query:

        SELECT s.doc_id AS doc_id,
               s.sentence_id AS sentence_id,
               max(s.lemma) AS lemma,
               max(s.words) AS words,
               array_accum(m.mention_id) AS mention_ids,
               array_accum(m.word) AS mention_words,
               array_accum(m.type) AS types,
               array_accum(m.start_pos) AS starts,
               array_accum(m.end_pos) AS ends
        FROM sentence s,
             mentions m
        WHERE s.doc_id = m.doc_id AND
              s.sentence_id = m.sentence_id
        GROUP BY s.doc_id,
                 s.sentence_id
"""

import sys
from lib import dd as ddlib

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (doc_id, sentence_id, lemma_str, words_str, mention_ids_str, \
    mention_words_str, types_str, starts_str, ends_str) = row.strip().split('\t')

  lemma = lemma_str.split(ARR_DELIM)
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
  if len(mentions) > 20 or len(words) > 100:
    continue

  # at this point we have a list of the mentions in this sentence

  # go through all pairs of mentions
  for m1 in mentions:
    # make sure that the first mention is a PER or ORG
    if m1["type"] not in ["PERSON", "ORGANIZATION"]:
      continue

    for m2 in mentions:
      if m1["mention_id"] == m2["mention_id"]:
        continue

      # the spans of the mentions
      span1 = ddlib.Span(begin_word_id=m1["start"], length=m1["end"] - m1["start"])
      span2 = ddlib.Span(begin_word_id=m2["start"], length=m2["end"] - m2["start"])

      # the lemma sequence between the mention spans
      lemma_between = ddlib.tokens_between_spans(lemma, span1, span2)
      if lemma_between.is_inversed:
        feature = "WORDSEQ_INV:" + "_".join(lemma_between.elements).lower()
      else:
        feature = "WORDSEQ_" + "_".join(lemma_between.elements).lower()

      # doc_id, mid1, mid2, word1, word2, type1, type2, feature
      output = [doc_id, m1["mention_id"], m2["mention_id"], m1["word"], m2["word"], m1["type"], m2["type"], feature]
      
      # make sure each of the strings we will output is encoded as utf-8
      map(lambda x: x.decode('utf-8', 'ignore'), output)

      print "\t".join(output)



