---
layout: default
---

# Extracting features from mention-level relation candidates

Now that we have extracted the entity mentions, we can find the mention-level relation candidates and extract features from them. This way the system will learn whether or not these candidates are actually valid instances a relation involving the mentions.

We will extract 2 features:
- The word sequence between the mentions
- The dependency path between the mentions.

Refer to http://www.stanford.edu/~jurafsky/mintz.pdf for a more detailed discussion on feature extraction.

## Relation mention feature: word sequence

Once we have identified the entity mentions in text, we can extract features from all mention pairs in the same sentence (these mentions pairs are referred to as relation mentions). This extractor will extract the *word sequence* feature for a relation mention: the exact sequence of words that occurs between the two mentions.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_feature_wordseq {
  input: """
    SELECT s.doc_id AS doc_id,
           s.sentence_id AS sentence_id,
           array_to_string(max(s.lemma), '~^~') AS lemma,
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
  output_relation: "relation_mention_features"
  udf: ${APP_HOME}"/udf/ext_relation_mention_features_wordseq.py"
  style: "tsv_extractor"
  dependencies: ["ext_cleanup", "ext_mention"]
}
```

**Input:** the list of mentions in a sentence, with information about each mention and about the whole sentence. Specically, each line in the input to this extractor UDF is a row of the input query in TSV format, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_55 Larijani~^~,~^~head~^~of~^~Iran~^~'s~^~supreme~^~national~^~security~^~council~^~,~^~be~^~a~^~natural~^~conservative~^~but~^~he~^~moderate~^~and~^~distinctly~^~undramatic~^~language~^~contrast~^~starkly~^~with~^~the~^~more~^~volatile~^~rhetoric~^~of~^~President~^~Mahmoud~^~Ahmadinejad~^~.   Larijani~^~,~^~head~^~of~^~Iran~^~'s~^~supreme~^~national~^~security~^~council~^~,~^~is~^~a~^~natural~^~conservative~^~but~^~his~^~moderate~^~and~^~distinctly~^~undramatic~^~language~^~contrasts~^~starkly~^~with~^~the~^~more~^~volatile~^~rhetoric~^~of~^~President~^~Mahmoud~^~Ahmadinejad~^~. AFP_ENG_20070405.0102.LDC2009T13_515_519~^~AFP_ENG_20070405.0102.LDC2009T13_522_555~^~AFP_ENG_20070405.0102.LDC2009T13_570_582~^~AFP_ENG_20070405.0102.LDC2009T13_698_717~^~AFP_ENG_20070405.0102.LDC2009T13_688_697~^~AFP_ENG_20070405.0102.LDC2009T13_497_505 iran~^~supreme national security council~^~conservative~^~mahmoud ahmadinejad~^~president~^~larijani    LOCATION~^~ORGANIZATION~^~IDEOLOGY~^~PERSON~^~TITLE~^~PERSON    4~^~6~^~14~^~31~^~30~^~0    5~^~10~^~15~^~33~^~31~^~1

**Output:** rows in `relation_mention_features` table, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_497_505    AFP_ENG_20070405.0102.LDC2009T13_515_519    larijani    iran    PERSON  LOCATION    WORDSEQ_,_head_of
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_497_505    AFP_ENG_20070405.0102.LDC2009T13_522_555    larijani    supreme national security council   PERSON  ORGANIZATION    WORDSEQ_,_head_of_iran_'s
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_497_505    AFP_ENG_20070405.0102.LDC2009T13_570_582    larijani    conservative    PERSON  IDEOLOGY    WORDSEQ_,_head_of_iran_'s_supreme_national_security_council_,_be_a_natural

We will be using the `dd` library (located in `$APP_HOME/udf/lib`) in this extractor. In particular, we will make use of the object `Span` and the method `tokens_between_spans()`. `Span` represents the span of a particular mention (consecutive indices of words in a sentence). `Span` is simply a wrapper around a tuple of integers (begin_word_id, length) where begin_word_id is the position in the sentence of the first word of the mention and length is the number of words that the mention contains. `tokens_between_spans()` takes in an array of lemma and 2 `Span` objects each representing a mention, and returns a list of the lemma between the spans.

The script `$APP_HOME/udf/ext_relation_mention_features_wordseq.py` is the UDF for this extractor:

```python
#! /usr/bin/env python

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
```

## Relation mention feature: dependency path

In addition to the word sequence feature, we can extract a lexical feature: the dependency path between the mentions in the sentence. This extractor will make use the *dep_graph* column of the `sentence` table, which gives a list of dependency edges in the sentence's dependency tree. The dd library included in the `$APP_HOME/udf/lib` directory provides some utilities for making the parsing of the dependency tree easier.

Refer to http://www.stanford.edu/~jurafsky/mintz.pdf for more details about this feature.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_feature_deppath {
  input: """
    SELECT s.doc_id AS doc_id,
           s.sentence_id AS sentence_id,
           array_to_string(max(s.lemma), '~^~') AS lemma,
           replace(array_to_string(max(s.dep_graph), '~^~'), E'\t', ' ') AS dep_graph,
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
  output_relation: "relation_mention_features"
  udf: ${APP_HOME}"/udf/ext_relation_mention_features_deppath.py"
  style: "tsv_extractor"
  dependencies: ["ext_cleanup", "ext_mention"]
}
```

**Input:** the list of mentions in a sentence, with information about each mention and about the whole sentence. Specically, each line in the input to this extractor UDF is a row of the input query in TSV format, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_55 Larijani~^~,~^~head~^~of~^~Iran~^~'s~^~supreme~^~national~^~security~^~council~^~,~^~be~^~a~^~natural~^~conservative~^~but~^~he~^~moderate~^~and~^~distinctly~^~undramatic~^~language~^~contrast~^~starkly~^~with~^~the~^~more~^~volatile~^~rhetoric~^~of~^~President~^~Mahmoud~^~Ahmadinejad~^~.   10 amod 7~^~10 amod 8~^~10 nn 9~^~10 poss 5~^~18 conj_and 21~^~21 advmod 20~^~15 cop 12~^~15 det 13~^~15 conj_but 23~^~15 nsubj 1~^~15 amod 14~^~29 advmod 27~^~29 det 26~^~29 amod 28~^~29 prep_of 33~^~23 prep_with 29~^~23 nsubj 22~^~23 advmod 24~^~22 amod 18~^~22 amod 21~^~22 poss 17~^~33 nn 31~^~33 nn 32~^~1 appos 3~^~3 prep_of 10   Larijani~^~,~^~head~^~of~^~Iran~^~'s~^~supreme~^~national~^~security~^~council~^~,~^~is~^~a~^~natural~^~conservative~^~but~^~his~^~moderate~^~and~^~distinctly~^~undramatic~^~language~^~contrasts~^~starkly~^~with~^~the~^~more~^~volatile~^~rhetoric~^~of~^~President~^~Mahmoud~^~Ahmadinejad~^~. AFP_ENG_20070405.0102.LDC2009T13_515_519~^~AFP_ENG_20070405.0102.LDC2009T13_522_555~^~AFP_ENG_20070405.0102.LDC2009T13_570_582~^~AFP_ENG_20070405.0102.LDC2009T13_698_717~^~AFP_ENG_20070405.0102.LDC2009T13_688_697~^~AFP_ENG_20070405.0102.LDC2009T13_497_505 iran~^~supreme national security council~^~conservative~^~mahmoud ahmadinejad~^~president~^~larijani    LOCATION~^~ORGANIZATION~^~IDEOLOGY~^~PERSON~^~TITLE~^~PERSON    4~^~6~^~14~^~31~^~30~^~0    5~^~10~^~15~^~33~^~31~^~1

**Output:** rows in `relation_mention_features` table, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_522_555    AFP_ENG_20070405.0102.LDC2009T13_570_582    supreme national security council   conservative    --prep_of->head--appos->larijani--nsubj->|SAMEPATH  ORGANIZATION    IDEOLOGY
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_522_555    AFP_ENG_20070405.0102.LDC2009T13_698_717    supreme national security council   mahmoud ahmadinejad --prep_of->head--appos->larijani--nsubj->|conservative|<-conj_but--contrast<-prep_with--rhetoric<-prep_of-- ORGANIZATION    PERSON
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_522_555    AFP_ENG_20070405.0102.LDC2009T13_688_697    supreme national security council   president   --prep_of->head--appos->larijani--nsubj->|conservative|<-conj_but--contrast<-prep_with--rhetoric<-prep_of--ahmadinejad<-nn--    ORGANIZATION    TITLE

We will be using the `dd` library (located in `$APP_HOME/udf/lib`) in this extractor. In particular, we will make use of the objects `Word` and `DepEdge`, and the methods `unpack_words()` and `dep_path_between_words`. `Word` is a wrapper around a given word in a sentence, and contains the lemma, the POS and NER tags, as well as the dependency parent and the label for the dependency edge between the parent and the current word. `DepEdge` is a wrapper around a dependency edge and contains the 2 words, the edge label, and a flag indicating whether that edge is on the left or the right side of the root. `unpack_words()` takes in a dictionary that contains the lemma list, the word list, the dependency graph list output by the NLP parser, and a function that can convert a dependency graph edge (one of the items in the dep_graph list) to a tuple of (parent_index, labe, child_index). `unpack_words()` returns a list of `Word` objects. `dep_path_between_words()` takes in a list of `Word` objects (produced by `unpack_words()`) and 2 indices corresponding to words, returns a list of `DepEdge` objects corresponding to the dependency path between the 2 words. Our extractor uses the list of `DepEdge` objects to create a feature from the dependency path.

In addition to the dependency path feature, this extractor also outputs a feature corresponding to the presence of the words "wife", "widow", or "husband" on the dependency path, which helps to identify the spouse relation.

The script `$APP_HOME/udf/ext_relation_mention_features_deppath.py` is the UDF for this extractor:

```python
#! /usr/bin/env python

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
```


Next, we need to perform [entity linking](entity_linking.md).