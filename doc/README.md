---
layout: default
---

Knowledge Base Population (KBP)
====

In this document we will build an application for the slot filling (relation extraction) task of the 
[TAC KBP competition](http://www.nist.gov/tac/2014/KBP/). This example uses a sample of the data for the 2010 task. Note that the data provided in this example application is only 0.2% of the original corpus so the recall (and thus the F1 score) will be low. However, using 100% of the 2010 corpus, this example system achieves an F1 score of 37 on the KBP task.

## Application overview

The application is an extension of the [mention-level extraction system](http://deepdive.stanford.edu/doc/walkthrough-mention.html), so please make sure you have gone through that part of the tutorial and have an understanding of how to do basic relation extraction in DeepDive. The main difference here is that there are more relationships to extract and more data. The current example is also a mention-level system, so the goal is, given the following input:

- a set of sentences with NLP features
- a set of Freebase entities
- an entity-level training set of the form *(entity1, relation, entity2)*,

to extract tuples of the form *(mention1, relation, mention2)*.

This tutorial will walk you through building a full DeepDive application that extracts the TAC KBP relationships between mentions of entities in raw text. We use news articles and blogs as our input data and want to extract all pairs of entity mentions that participate in the KBP relations (e.g. *Barack Obama* and *Michelle Obama* for the `spouse` relation).

The application performs the following high-level steps:

1. Load data from provided database dump
2. Extract features. This includes steps to:
  - Extract entity mentions from sentences
  - Extract lexical and syntactic features from mention-level relation candidates (entity mention pairs in the same sentence)
  - Extract candidates for coreferent mentions
  - Extract features for entity linking (linking Freebase entities to mentions in text)
  - Generate positive and negative training examples for relation candidates
  - Extract the non-example mention-level relation candidates
3. Generate a factor graph using inference rules
4. Perform inference and learning
5. Generate results

Note that in this example we will refer to mention-level relation candidates as relation mentions.

For simplicity, we will start by loading a database dump that contains all of the tables necessary to run the system.

Let us now go through the steps to get the example KBP system up and running.

### Contents

* [Installing DeepDive](#installing-deepdive)
* [Setting up KBP application](#setting-up-kbp-application)
  - [Cloning the repository](#cloning-the-repository)
  - [Connecting to the database](#connecting-to-the-database)
  - [Loading initial data](#loading-initial-data)
* [Running KBP application](#running-kbp-application)
* [Evaluating the results](#evaluating-the-results)
* [Writing extractors](#writing-extractors)
* [Debugging extractors](#debugging-extractors)
* [Writing inference rules](#writing-inference-rules)

## Installing DeepDive

This tutorial assumes a working installation of DeepDive.
Please go through the
[example application walkthrough](http://deepdive.stanford.edu/doc/walkthrough.html) before proceeding.

After following the walkthrough, your "deepdive" directory should contain a folder called "app", which should contain a folder called "spouse".

## Setting up KBP application

### Cloning the repository

Navigate to the folder "app" (same folder as you use in the walkthrough), 
clone this repository, and switch to the correct branch.

    >> git clone https://github.com/zhangce/kbp.git
    >> cd kbp
    >> git checkout mike-readme

To validate this step, you should see:

    >> git branch
      master
      mike-ce-stringlib
    * mike-readme
      mike-tsv-extractors
    >> ls
    README.md           data            env_db.sh       run-evaluate.sh     schema.sql          udf
    application.conf    env.sh          evaluation      run.sh              setup_database.sh          		
	
From now on we will be working in the kbp directory.

### Connecting to the database

Change the database settings in the file `env_db.sh`, whose original contents is:

    #! /bin/bash
    export DBNAME=deepdive_kbp_mikhail
    export PGHOST=localhost
    export PGPORT=5432

Change this file to point to your database.

To validate this step, you should be able to connect to the database by running the following commands:
    
    >> source env_db.sh
    >> psql -l
                                            List of databases
              Name           |  Owner   | Encoding | Collate | Ctype |   Access privileges   
    -------------------------+----------+----------+---------+-------+-----------------------
     template0               | postgres | UTF8     | C       | C     | =c/postgres          +
    ...

### Loading initial data

The initial database dump contains the following tables:
- `sentence`: contains processed sentence data by an [NLP extractor](http://deepdive.stanford.edu/doc/walkthrough-extras.html#nlp_extractor). This table contains tokenized words, lemmatized words, POS tags, NER tags, dependency paths for each sentence. The table contains 70805 sentences, which is 0.2% of the full corpus for 2010.
- `kb`: Contains tuples of the form (entity1, relation, entity2); this is the knowledge base used for distant supervision.
- `entities`: A set of entities from Freebase.
- `fbalias`: Freebase aliases for entities. An alias is an alternate name for an entity; for example, William Henry Gates III is an alias for Bill Gates.
- `relation_types`: The typed relations we care to extract.
- `incompatible_relations`: Contains tuples of the form (relation1, relation2) where relation2 is incompatible with relation1. This is used to generate negative examples (given (e1, relation1, e2), (e1, relation2, e2) will be a negative example).
- `ea`: Contains the ground truth for the evaluation; to be used for error analysis.

There are 3 additional tables that the system will need to create, to be used by the extractors. The tables are:
- `mentions` (populated by `ext_mention`)
- `relation_mentions` (populated by `ext_relation_mention_positive`, `ext_relation_mention_negative`, and `ext_relation_mention`)
- `relation_mention_features` (populated by `ext_relation_mention_feature`)

The first 7 tables are included in the database dump, and the second 3 tables are created in `schema.sql`. The script `setup_database.sh` will load all 10 tables into the database.

Load the initial database:

    >> sh setup_database.sh

You may see some errors, but don't worry, they can be ignored. Validate that this step succeeded as follows:

    >> source env_db.sh

    >> psql $DBNAME -c "\d"
                       List of relations
     Schema |           Name            | Type  |  Owner   
    --------+---------------------------+-------+----------
     public | ea                        | table | czhang
     public | entities                  | table | czhang
     public | fbalias                   | table | czhang
     public | incompatible_relations    | table | msushkov
     public | kb                        | table | czhang
     public | mentions                  | table | msushkov
     public | relation_mention_features | table | msushkov
     public | relation_mentions         | table | msushkov
     public | relation_types            | table | msushkov
     public | sentence                  | table | czhang
    (10 rows)

For a more detailed verification of `setup_database.sh` (recommended), please see [verifying setup_database.sh](doc/verify_setup_database.md).

Now that we have loaded all the necessary data, we can run the application.

## Running KBP application

Make sure you are in the kbp directory. To run the application, type in:

    >> time sh run.sh
    ...
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [profiler] INFO  Summary Report
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [profiler] INFO  ext_cleanup SUCCESS [251 ms]
    04:26:09 [profiler] INFO  ext_mention SUCCESS [16997 ms]
    04:26:09 [profiler] INFO  ext_coref_candidate SUCCESS [2399 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_feature_deppath SUCCESS [34105 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_feature SUCCESS [63297 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_person SUCCESS [67563 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_organization SUCCESS [2258 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_title SUCCESS [3781 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_title2 SUCCESS [5060 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_location SUCCESS [8089 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_person SUCCESS [23261 ms]
    04:26:09 [profiler] INFO  ext_el_feature_coref SUCCESS [24390 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_title SUCCESS [32075 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_location SUCCESS [44660 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_organization SUCCESS [48183 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_positive SUCCESS [33341 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_negative SUCCESS [189 ms]
    04:26:09 [profiler] INFO  ext_relation_mention SUCCESS [3606 ms]
    04:26:09 [profiler] INFO  inference_grounding SUCCESS [16311 ms]
    04:26:09 [profiler] INFO  inference SUCCESS [47145 ms]
    04:26:09 [profiler] INFO  calibration plot written to /Users/czhang/Desktop/dd2/deepdive/out/2014-05-22T042159/calibration/relation_mentions.is_correct.png [0 ms]
    04:26:09 [profiler] INFO  calibration SUCCESS [14562 ms]
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [taskManager] INFO  Completed task_id=report with Success(Success(()))
    04:26:09 [profiler] DEBUG ending report_id=report
    04:26:09 [taskManager] INFO  1/1 tasks eligible.
    04:26:09 [taskManager] INFO  Tasks not_eligible: Set()
    04:26:09 [taskManager] DEBUG Sending task_id=shutdown to Actor[akka://deepdive/user/taskManager#1841581299]
    04:26:09 [profiler] DEBUG starting report_id=shutdown
    04:26:09 [EventStream] DEBUG shutting down: StandardOutLogger started
    Not interrupting system thread Thread[process reaper,10,system]
    [success] Total time: 251 s, completed May 22, 2014 4:26:09 AM
        
    real  4m15.001s
    user  2m30.093s
    sys 0m26.283s

To see some example results, type in:

    >> source env_db.sh
    >> psql $DBNAME -c "select word1, word2, rel from relation_mentions_is_correct_inference where rel = 'per:title' order by expectation desc limit 10;"
              word1          |   word2    |    rel    
    -------------------------+------------+-----------
     jose eduardo dos santos | president  | per:title
     kevin stallings         | coach      | per:title
     anthony hamilton        | father     | per:title
     karyn bosnak            | author     | per:title
     mahmoud ahmadinejad     | president  | per:title
     fulgencio batista       | dictator   | per:title
     raul castro             | president  | per:title
     dean spiliotes          | consultant | per:title
     simon cowell            | judge      | per:title
     castro                  | elder      | per:title
    (10 rows)

These results are the highest-confidence (mention1, relation, mention2) tuples produced by the system where the relation is 'per:title'. We can see that the system seems to do well at identifying people's titles.

## Evaluating the results

The KBP application contains a scorer for the TAC KBP slot filling task. The example system will not achieve a high score on the task because our sample of 70805 sentences is only 0.2% of the full corpus.

To get the score, type in:

    >> sh run-evaluate.sh
    ...
                                  2010 scores:
    [STDOUT]                      Recall: 5.0 / 1040.0 = 0.004807692307692308
    [STDOUT]                      Precision: 5.0 / 8.0 = 0.625
    [STDOUT]                      F1: 0.009541984732824428
                              } << Scoring System [0.389 seconds]
                              Running SFScore2010 {
    [WARN SFScore]              official scorer exited with non-zero exit code
                              } [0.138 seconds]
                              Generating PR Curve {
    [Eval]                      generating PR curve with 8 points
    [Eval]                      P/R curve data generated in file: /tmp/stanford1.curve
                              } 
                              Score {
    [Result]                    |           Precision: 62.500
    [Result]                    |              Recall: 00.481
    [Result]                    |                  F1: 00.954
    [Result]                    |
    [Result]                    |   Optimal Precision: �
    [Result]                    |      Optimal Recall: �
    [Result]                    |          Optimal F1: -∞
    [Result]                    |
    [Result]                    | Area Under PR Curve: 0.0
                              } 
                            } << Evaluating Test Entities [0.922 seconds]
    [MAIN]                  work dir: /tmp
                          } << main [2.405 seconds]

In this log, the precision is 62.5 (human agreement rate is around 70), and recall is low
since our sample is 0.2% of the full corpus.

For the ease of error analysis, we also include a relational-form of the ground truth. To
see the ground truth, type in:

    >> source env_db.sh 
    >> psql $DBNAME -c "SELECT * FROM ea limit 10;"
     query |                  sub                   |           rel            |           obj            
    -------+----------------------------------------+--------------------------+--------------------------
     SF208 | kendra wilkinson                       | per:age                  | 23
     SF209 | chelsea library                        | org:alternate_names      | chelsea district library
     SF212 | chad white                             | per:age                  | 22
     SF211 | paul kim                               | per:age                  | 24
     SF210 | crown prosecution service              | org:alternate_names      | cps
     SF262 | noordhoff craniofacial foundation      | org:alternate_names      | ncf
     SF263 | national christmas tree association    | org:city_of_headquarters | chesterfield
     SF260 | north phoenix baptist church           | org:city_of_headquarters | phoenix
     SF228 | professional rodeo cowboys association | org:alternate_names      | prca
     SF229 | new hampshire institute of politics    | org:city_of_headquarters | manchester
    (10 rows)

Now that we have set up the application and have run it end to end, let's look at the code.

## Writing extractors

The extractors are created in `application.conf`. Several extractors in this example are [TSV extractors](http://deepdive.stanford.edu/doc/extractors.html#tsv_extractor), and the UDFs for them are contained in `APP_HOME/udf`. However, the majority are [SQL extractors](http://deepdive.stanford.edu/doc/extractors.html#sql_extractor) that do not have UDFs.

As stated in the [overview](#application-overview), the extractors perform the following high-level tasks:

- Extract entity mentions from sentences.
- Extract lexical and syntactic features for relation mentions (entity mentions pairs in the same sentence).
- Extract candidates for coreferent mentions.
- Extract features for entity linking (linking Freebase entities to mentions in text). These features include:
  - Exact string match
  - Freebase alias
  - Coreference
- Add positive and negative training examples for relation mentions.
- Extract the relation mentions.

Note that the entity linking step is necessary because our training data is at the entity level, but in order for the system to learn text patterns, this needs to be mapped to the mention level. That entity -> mention mapping is the entity linking.

We will walk through each of the extractors in more detail below.

### Cleanup

The `ext_cleanup` extractor cleans up the tables that will be populated by the extractors. This extractor is defined in `application.conf` using the following code:

```bash
ext_cleanup {
  sql: """
    DELETE FROM relation_mentions;
    DELETE FROM relation_mention_features;
    DELETE FROM mentions;
  """
  style: "sql_extractor"
}
```

### Entity mentions

We first need to identify the entity mentions in the text. Given a set of sentences, the entity mention extractor will populate the `mentions` table using NER tags from the `sentence` table, generated by the NLP toolkit.

This extractor is defined in `application.conf` using the following code:

```bash
ext_mention {
  input : """
    SELECT doc_id,
           sentence_id,
           my_array_to_string(words, '~^~', 'NULL') AS words,
           my_array_to_string(ner, '~^~', 'NULL') AS ner,
           my_array_to_string(character_offset_begin, '~^~', 'NULL') AS character_offset_begin,
           my_array_to_string(character_offset_end, '~^~', 'NULL') AS character_offset_end
    FROM sentence
  """
  output_relation: "mentions"
  udf: ${APP_HOME}"/udf/ext_mention.py"
  style: "tsv_extractor"
  dependencies : ["ext_cleanup"]
}
```

Note that `my_array_to_string` is a function defined in `schema.sql` and is a simple modification of the default PSQL `array_to_string` function: in addition to the array and delimiter arguments, the function also accepts a string with which NULL values in the array will be replaced. Here we wish to replace the NULL elements in the arrays with the word 'NULL'.

The input query simply selects the appropriate columns from the sentence table and converts to strings the columns that contain arrays (since TSV extractors take in strings as input).

**Input:** sentences along with NER tags. Specically, each line in the input to this extractor UDF is a row in the `sentence` table in TSV format, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_55 Larijani~^~,~^~head~^~of~^~Iran~^~'s~^~supreme~^~national~^~security~^~council~^~,~^~is~^~a~^~natural~^~conservative~^~but~^~his~^~moderate~^~and~^~distinctly~^~undramatic~^~language~^~contrasts~^~starkly~^~with~^~the~^~more~^~volatile~^~rhetoric~^~of~^~President~^~Mahmoud~^~Ahmadinejad~^~. PERSON~^~O~^~O~^~O~^~COUNTRY~^~O~^~ORGANIZATION~^~ORGANIZATION~^~ORGANIZATION~^~ORGANIZATION~^~O~^~O~^~O~^~O~^~IDEOLOGY~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~O~^~TITLE~^~PERSON~^~PERSON~^~O   497~^~505~^~507~^~512~^~515~^~519~^~522~^~530~^~539~^~548~^~555~^~557~^~560~^~562~^~570~^~583~^~587~^~591~^~600~^~604~^~615~^~626~^~635~^~645~^~653~^~658~^~662~^~667~^~676~^~685~^~688~^~698~^~706~^~717   505~^~506~^~511~^~514~^~519~^~521~^~529~^~538~^~547~^~555~^~556~^~559~^~561~^~569~^~582~^~586~^~590~^~599~^~603~^~614~^~625~^~634~^~644~^~652~^~657~^~661~^~666~^~675~^~684~^~687~^~697~^~705~^~717~^~718

**Output:** rows in `mentions` table, e.g.:

    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_497_505    AFP_ENG_20070405.0102.LDC2009T13_55 larijani    PERSON  0   1
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_515_519    AFP_ENG_20070405.0102.LDC2009T13_55 iran    LOCATION    4   5
    AFP_ENG_20070405.0102.LDC2009T13    AFP_ENG_20070405.0102.LDC2009T13_522_555    AFP_ENG_20070405.0102.LDC2009T13_55 supreme national security council   ORGANIZATION    6   10
    ...

A mention can consist of multiple words (e.g. Barack Obama); the way we can identify these is if all of these words have the same NER tag. This extractor goes through all the words in the sentence and outputs as a mention the consecutive words that have the same NER tag.

The script `$APP_HOME/udf/ext_mention.py` is the UDF for this extractor:

```python
#! /usr/bin/env python

import sys

# the NER tags that wil not correspond to entity mentions types
EXT_MENTION_IGNORE_TYPE = {'URL': 1, 'NUMBER' : 1, 'MISC' : 1, 'CAUSE_OF_DEATH' : 1,
    'CRIMINAL_CHARGE' : 1, 'DURATION' : 1, 'MONEY' : 1, 'ORDINAL' : 1, 'RELIGION' : 1,
    'SET' : 1, 'TIME' : 1}

# words that are representative of the TITLE type
EXT_MENTION_TITLE_TYPE = {'winger' : 1, 'singer\\\\/songwriter' : 1, 'founder' : 1,
    'president' : 1, 'executive director' : 1, 'producer' : 1, 'star' : 1, 'musician' : 1,
    'nightlife impresario' : 1, 'lobbyist' : 1}

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (doc_id, sentence_id, words_str, ner_str, character_offset_begin_str, \
    character_offset_end_str) = row.strip().split('\t')

  words = words_str.split(ARR_DELIM)
  ner = ner_str.split(ARR_DELIM)
  character_offset_begin = map(lambda x: int(x), character_offset_begin_str.split(ARR_DELIM))
  character_offset_end = map(lambda x: int(x), character_offset_end_str.split(ARR_DELIM))

  # keep track of words whose NER tags we look at
  history = {}

  # go through each word in the sentence
  for i in range(0, len(words)):
    # if we already looked at this word's NER tag, skip it
    if i in history:
      continue

    # the NER tag for the current word
    curr_ner = ner[i]

    # skip this word if this NER tag should be ignored
    if curr_ner in EXT_MENTION_IGNORE_TYPE:
      continue

    # collapse specific location types
    if curr_ner in ["CITY", "COUNTRY", "STATE_OR_PROVINCE"]:
      curr_ner = "LOCATION"

    # if the current word has a valid NER tag
    if curr_ner != 'O' and curr_ner != 'NULL':
      j = i

      # go through each of the words after the current word until the end of the sentence
      for j in range(i, len(words)):
        nerj = ner[j]

        # collapse specific location types
        if nerj in ["CITY", "COUNTRY", "STATE_OR_PROVINCE"]:
          nerj = "LOCATION"

        # go until the NER tags of word 1 and word 2 do not match
        if nerj != curr_ner:
          break

      # at this point we have a mention that consists of consecutive words with the same NER 
      # tag (or just a single word if the next word's NER tag is different)

      # construct a unique ID for this entity mention
      mention_id = doc_id + "_%d_%d" % (character_offset_begin[i], character_offset_end[j-1])

      # if our mention is just a single word, we want just that word
      if i == j:
        j = i + 1
        word = words[i]
        history[i] = 1

      # if our mention is multiple words, combine them and mark that we have already seen them
      else:
        word = " ".join(words[i:j])
        for w in range(i,j):
          history[w] = 1

      # doc_id, mention_id, sentence_id, word, type, start_pos, end_pos
      output = [doc_id, mention_id, sentence_id, word.lower(), curr_ner, str(i), str(j)]

      # make sure each of the strings we will output is encoded as utf-8
      map(lambda x: x.decode('utf-8', 'ignore'), output)

      print "\t".join(output)
    
    # if this word has an NER tag of '0' or NULL
    else:
      # if the current word is one of the known titles, then we have a TITLE mention
      if words[i].lower() in EXT_MENTION_TITLE_TYPE:
        history[i] = 1
        word = words[i]
        
        # construct a unique ID for this entity mention
        mention_id = doc_id + "_%d_%d" % (character_offset_begin[i], character_offset_end[i])
        
        # doc_id, mention_id, sentence_id, word, type, start_pos, end_pos
        output = [doc_id, mention_id, str(sentence_id), word.lower(), 'TITLE', str(i), str(i + 1)]

        # make sure each of the strings we will output is encoded as utf-8
        map(lambda x: x.decode('utf-8', 'ignore'), output)

        print "\t".join(output)
```

### Extracting features from mention-level relation candidates

Now that we have extracted the entity mentions, we can find the mention-level relation candidates and extract features from them. This way the system will learn whether or not these candidates are actually valid instances a relation involving the mentions.

We will extract 2 features:
- The word sequence between the mentions
- The dependency path between the mentions.

Refer to http://www.stanford.edu/~jurafsky/mintz.pdf for a more detailed discussion on feature extraction.

#### Relation mention feature: word sequence

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

#### Relation mention feature: dependency path

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

## Coreferent mentions

Once we have identified the mentions in text, we can find the candidate set of coreferent mentions. A pair of mentions is coreferent if the following conditions hold:
- both mentions appear in the same document
- both are of the *PERSON* type
- one begins with the text of the other.

This extractor is defined in `application.conf` using the following code:

```bash
ext_coref_candidate {
  sql: """
    DROP TABLE IF EXISTS coref_candidates;

    CREATE TABLE coref_candidates AS
      SELECT DISTINCT ON (m0.word, m1.word, m0.mention_id)
           m0.doc_id,
           m0.mention_id AS mid1,
           m1.mention_id AS mid2
      FROM mentions m0,
           mentions m1
      WHERE m0.doc_id = m1.doc_id AND
            m0.type = 'PERSON' AND
            m1.type = 'PERSON' AND
            m1.word LIKE m0.word || ' %' AND
            m0.mention_id <> m1.mention_id;
  """
  style: "sql_extractor"
  dependencies : ["ext_mention"]
}
```

**Query result:** mention pairs that are candidates for coreference, e.g.:

                  doc_id              |                    mid1                    |                    mid2                    
    ----------------------------------+--------------------------------------------+--------------------------------------------
     eng-WL-11-174595-12967958        | eng-WL-11-174595-12967958_8102_8107        | eng-WL-11-174595-12967958_8222_8234
     eng-WL-11-174595-12967958        | eng-WL-11-174595-12967958_8522_8527        | eng-WL-11-174595-12967958_8038_8050
     eng-WL-11-174595-12967958        | eng-WL-11-174595-12967958_9014_9019        | eng-WL-11-174595-12967958_8038_8050
     
Let's show the results with the mention and entity text for clarity:

              doc_id           |                mid1                 | word1 |                mid2                 |    word2     
    ---------------------------+-------------------------------------+-------+-------------------------------------+--------------
     eng-WL-11-174595-12967958 | eng-WL-11-174595-12967958_8102_8107 | aaron | eng-WL-11-174595-12967958_8222_8234 | aaron carter
     eng-WL-11-174595-12967958 | eng-WL-11-174595-12967958_8522_8527 | aaron | eng-WL-11-174595-12967958_8222_8234 | aaron carter
     eng-WL-11-174595-12967958 | eng-WL-11-174595-12967958_9014_9019 | aaron | eng-WL-11-174595-12967958_8222_8234 | aaron carter

This is an SQL extractor, which means that it has no UDF but simply executes a query.

## Entity linking

### Entity linking: exact string match between entities and mentions

To identify which mentions in text refer to which entities, we need to perform entity linking. This involves extracting specific features from (entity, mention) pairs. This extractor extracts the "exact string match" feature between (entity, mention) pairs (this feature is denoted as 'es'). An (entity, mention) pair emits the 'es' feature if the following conditions hold:
- the entity and mention have corresponding types
- the entity and mention strings match exactly.

In the case of the *PERSON* entities and mentions, we have an additonal condition:
- the mention string contains a space.

There are several *exact-string-match* extractors for different types of entities and mentions:
- `ext_el_feature_extstr_person` considers mentions of the *PERSON* type and entities of the *people.person* type
- `ext_el_feature_extstr_location` considers mentions of the *LOCATION* type and entities of the *location.location* type
- `ext_el_feature_extstr_organization` considers mentions of the *ORGANIZATION* type and entities of the *organization.organization* type
- `ext_el_feature_extstr_title` considers mentions of the *TITLE* type and entities of the *business.job_title* type
- `ext_el_feature_extstr_title2` considers mentions of the *TITLE* type and entities of the *government.government_office_or_title* type

Each of these extractors is defined in `application.conf` using code nearly identical to the following, with some potential differences in the WHERE condition depending on the types. This example is for entities and mentions of the *LOCATION* type:

```bash
ext_el_feature_extstr_location {
  sql: """
    INSERT INTO el_features_highprec
      SELECT m.doc_id,
             m.mention_id,
             e.fid,
             'es'::TEXT AS feature
      FROM   mentions m,
             entities e
      WHERE  m.type = 'LOCATION' AND
             e.type = 'location.location' AND
             m.word = e.text;
  """
  dependencies : ["ext_el_feature_extstr_person"]
  style: "sql_extractor"
}
```

**Query result:** (entity, mention) pairs of the *LOCATION* type whose text matches exactly, e.g.:

                  doc_id              |                 mention_id                 |    fid    | feature 
    ----------------------------------+--------------------------------------------+-----------+---------
     NYT_ENG_20071001.0094.LDC2009T13 | NYT_ENG_20071001.0094.LDC2009T13_9731_9738 | m.0496l40 | es
     NYT_ENG_20070518.0055.LDC2009T13 | NYT_ENG_20070518.0055.LDC2009T13_8917_8924 | m.0496l40 | es
     APW_ENG_20081023.0044.LDC2009T13 | APW_ENG_20081023.0044.LDC2009T13_3225_3231 | m.0489wbm | es

Let's show the results with the mention and entity text for clarity:

                  doc_id              |                 mention_id                 |  word   |    fid    | entity_text | feature 
    ----------------------------------+--------------------------------------------+---------+-----------+-------------+---------
     NYT_ENG_20070514.0225.LDC2009T13 | NYT_ENG_20070514.0225.LDC2009T13_3328_3335 | milford | m.0206xw3 | milford     | es
     APW_ENG_20070317.0852.LDC2009T13 | APW_ENG_20070317.0852.LDC2009T13_857_864   | milford | m.0206xw3 | milford     | es
     APW_ENG_20070317.0852.LDC2009T13 | APW_ENG_20070317.0852.LDC2009T13_269_276   | milford | m.0206xw3 | milford     | es

All of these are SQL extractors, which means that they have no UDF but simply execute a query.

### Entity linking: exact string match between Freebase aliases for entities and mentions

In addition to exact string match between entities and mention, we consider in the entity linking step (entity, mention) pairs where the entity has a Freebase alias whose text is an exact match for the mention text. The extractors are similar to the exact string match above, but each input query now also performs a join on the `fbalias` table. The extractors extract the "alias" feature between (entity, mention) pairs (this feature is denoted as 'al'). An (entity, mention) pair emits the 'al' feature if the following conditions hold:
- the entity and mention have corresponding types
- the entity has a Freebase alias
- the entity's alias and mention text match exactly.

In the case of the *PERSON* entities and mentions, we have an additonal condition:
- the mention string contains a space.

There are several *alias* extractors for different types of entities and mentions:
- `ext_el_feature_alias_person` considers mentions of the *PERSON* type and entities of the *people.person* type
- `ext_el_feature_alias_location` considers mentions of the *LOCATION* type and entities of the *location.location* type
- `ext_el_feature_alias_organization` considers mentions of the *ORGANIZATION* type and entities of the *organization.organization* type
- `ext_el_feature_alias_title` considers mentions of the *TITLE* type and entities of the *business.job_title* type

Each of these extractors is defined in `application.conf` using code nearly identical to the following, with some potential differences in the WHERE condition depending on the types. This example is for entities and mentions of the *LOCATION* type:

```bash
ext_el_feature_alias_location {
  sql: """
    INSERT INTO el_features_highprec
      SELECT m.doc_id,
             m.mention_id,
             e.fid,
             'al'::TEXT AS feature
      FROM   mentions m,
             entities e,
             fbalias f
      WHERE  m.type = 'LOCATION' AND
             e.type = 'location.location' AND
             m.word = f.slot AND
             e.fid = f.fid;
  """
  dependencies : ["ext_el_feature_extstr_person"]
  style: "sql_extractor"
}
```

**Query result:** (entity, mention) pairs of the *LOCATION* type such that the entity has a Freebase alias whose text matches exactly the text of the mention, e.g.:
    
                  doc_id              |                mention_id                |    fid    | feature 
    ----------------------------------+------------------------------------------+-----------+---------
     eng-WL-11-174587-12962117        | eng-WL-11-174587-12962117_805_813        | m.0ldgnrl | al
     eng-WL-11-174595-12968511        | eng-WL-11-174595-12968511_11478_11486    | m.04drmh  | al
     APW_ENG_20080907.0722.LDC2009T13 | APW_ENG_20080907.0722.LDC2009T13_619_627 | m.04drmh  | al

Let's show the results with the mention and entity text for clarity:

                 doc_id               |               mention_id                 |   word   |     fid      | alias_text | feature 
    ----------------------------------+------------------------------------------+----------+--------------+------------+---------
        eng-WL-11-174587-12962117     |   eng-WL-11-174587-12962117_805_813      | the bank |  m.0ldgnrl   | the bank   | al
        eng-WL-11-174595-12968511     |   eng-WL-11-174595-12968511_11478_11486  | montreal |  m.04drmh    | montreal   | al
     APW_ENG_20080907.0722.LDC2009T13 | APW_ENG_20080907.0722.LDC2009T13_619_627 | montreal |  m.04drmh    | montreal   | al



All of these are SQL extractors, which means that they have no UDF but simply execute a query.

### Entity linking: coreferent mentions

We also consider in the entity linking step (entity, mention) pairs where the mention is coreferent with another mention m' such that the (entity, m') pair emits the "exact string match" feature. In other words, given the entity and mention pair (e1, m1) for which we have the entity linking feature 'es', and mention m2 that is coreferent with m1, choose (e1, m2) to have the coreference entity linking feature, denoted as 'co'.

This extractor is defined in `application.conf` using the following code:

```bash
ext_el_feature_coref {
  sql: """
    INSERT INTO el_features_highprec
      SELECT c.doc_id,
             c.mid1,
             el.fid,
             'co'::TEXT
      FROM   coref_candidates c,
             el_features_highprec el,
             entities e,
             mentions m
      WHERE  el.feature = 'es' AND
             c.mid2 = el.mention_id AND
             c.doc_id = el.doc_id;
  """
  dependencies : ["ext_coref_candidate", "ext_el_feature_extstr_person"]
  style: "sql_extractor"
}
```

**Query result:** (entity, mention) pairs that emit the 'co' feature, e.g.:

                  doc_id              |                     mid1                     |   fid    | text 
    ----------------------------------+----------------------------------------------+----------+------
     eng-WL-11-174594-12961460        | eng-WL-11-174594-12961460_1352_1359          | m.015f7  | co
     eng-WL-11-174594-12961460        | eng-WL-11-174594-12961460_1022_1029          | m.015f7  | co
     NYT_ENG_20071001.0094.LDC2009T13 | NYT_ENG_20071001.0094.LDC2009T13_10815_10818 | m.0dm0bw | co

Let's show the results with the mention and entity text for clarity:

                 doc_id               |                     mid1                     |  word   |   fid    |  entity_text   | text 
    ---------------------------+-----------------------------------------------------+---------+----------+----------------+------
        eng-WL-11-174594-12961460     |     eng-WL-11-174594-12961460_1352_1359      | britney | m.015f7  | britney spears | co
        eng-WL-11-174594-12961460     |     eng-WL-11-174594-12961460_1022_1029      | britney | m.015f7  | britney spears | co
     NYT_ENG_20071001.0094.LDC2009T13 | NYT_ENG_20071001.0094.LDC2009T13_10815_10818 |   ann   | m.0dm0bw |  ann davies    | co

## Adding training data

In order for the system to learn text patterns that indicate the presence of certain relationships between entities, we must provide training examples. We have an entity-level knowledge base of (entity1, relation, entity2) tuples (prodived in the database dump). Since our training data is entity-level but we need mention-level examples, we will use the distant supervision approach: for a given (entity1, relation, entity2) training example form the knowledge base, label all instances of (mention1, relation, mention2), where mention1 is a mention for the entity entity1 and mention2 is a mention for entity2, as being positive examples. To generate negative examples, use a list of incompatible relations.

Refer to http://www.stanford.edu/~jurafsky/mintz.pdf for a discussion on distant supervision.

### Training data: positive examples

The positive examples come from the existing knowledge base table, `kb`. The table contains tuples of the form (entity1, relation, entity2). Note that our training data is entity-level; however, in order for the system to learn text patterns this data needs to be mapped to the mention level. Also note that since we are adding positive examples we insert True into the `is_correct` column of the `relation_mentions` table.

For each (entity1, relation, entity2) tuple in the knowledge base, the extractor finds mentions m1 and m2 that link to entities entity1 and entity2, respectively, and then joins the result with the relation mention feature table in order to extract the rellevant relation mention information. This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_positive {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT r.doc_id,
                      r.mid1,
                      r.mid2,
                      r.word1,
                      r.word2,
                      kb.rel,
                      True
      FROM relation_mention_features r,
           el_features_highprec t1,
           el_features_highprec t2,
           kb
      WHERE r.mid1 = t1.mention_id AND
            r.mid2 = t2.mention_id AND
            t1.fid = kb.eid1 AND
            t2.fid = kb.eid2 AND
            r.doc_id = t1.doc_id AND
            r.doc_id = t2.doc_id;
  """
  dependencies : ["ext_el_feature_coref", "ext_el_feature_extstr_title", 
                  "ext_el_feature_extstr_organization", "ext_el_feature_extstr_location",
                  "ext_el_feature_extstr_person", "ext_coref_candidate", "ext_coref_candidate",
                  "ext_relation_mention_feature", "ext_relation_mention_feature_deppath", 
                  "ext_mention", "ext_el_feature_alias_person",
                  "ext_el_feature_alias_title", "ext_el_feature_alias_location",
                  "ext_el_feature_alias_organization"]
  style: "sql_extractor"
}
```

**Query result:** mention-level positive training examples, e.g.:
    
                  doc_id              |                    mid1                    |                    mid2                    |          word1           |   word2   |    rel    | bool 
    ----------------------------------+--------------------------------------------+--------------------------------------------+--------------------------+-----------+-----------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614   | AFP_ENG_20020206.0348.LDC2007T07_590_599   | george w. bush           | president | per:title | t
     AFP_ENG_20050523.0367.LDC2007T07 | AFP_ENG_20050523.0367.LDC2007T07_1242_1267 | AFP_ENG_20050523.0367.LDC2007T07_1232_1241 | akbar hashemi rafsanjani | president | per:title | t
     AFP_ENG_20050523.0367.LDC2007T07 | AFP_ENG_20050523.0367.LDC2007T07_1389_1411 | AFP_ENG_20050523.0367.LDC2007T07_1232_1241 | ayatollah ali khamenei   | president | per:title | t

### Training data: negative examples

Once we have constructed the positive examples, we can generate negative examples. The initial database contains a table called `incompatible_relations`: this table contains, for each of the relations r we want to extract, a relation that is incompatible with r. For example, for the relation `LOCATION_of_birth`, an incompatible relation would be `LOCATION_of_death`, since the same text patterns that would be indicative of the `LOCATION_of_birth` relation would not be indicative of the `LOCATION_of_death` relation.

More concretely, for a given positive training example

```(entity1, relation1, entity2),```

a negative example would be

```(entity1, relation2, entity2)```

where relation2 is incompatible with relation1. Note that since the table `relation_mentions` currently only contains the positive mention-level examples we generated in the above extractor, we can use that table directly to generate the negative examples by simply replacing the relations with incompatible relations. Also note that since we are adding negative examples we insert False into the `is_correct` column of the `relation_mentions` table.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_negative {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT t0.doc_id,
                      t0.mid1,
                      t0.mid2,
                      t0.word1,
                      t0.word2,
                      t1.type2,
                      False
      FROM relation_mentions t0,
           incompatible_relations t1
      WHERE t0.rel = t1.type1 AND
            t0.is_correct = True AND
            t0.rel <> t1.type2;
  """
  dependencies : ["ext_relation_mention_positive"]
  style: "sql_extractor"
}
```

**Query result:** mention-level negative training examples, e.g.:

                  doc_id              |                   mid1                   |                   mid2                   |     word1      |   word2   |       type2        | bool 
    ----------------------------------+------------------------------------------+------------------------------------------+----------------+-----------+--------------------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:age            | f
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:cause_of_death | f
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:children       | f

## Generating relation mentions

As the final extractor, we generate the non-example relation mentions that we want to run inference on. Each of these relation mentions will have NULL in the `is_correct` column, meaning that DeepDive will treat it as a random variable and will perform inference on its value. Since we have already generated the `relation_mention_features` table, we can simply use that, along with the `relation_types` table, to get the appropriately-typed relation mentions.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT t1.doc_id,
                      t1.mid1,
                      t1.mid2,
                      t1.word1,
                      t1.word2,
                      t0.rel,
                      NULL::boolean
      FROM relation_types t0,
           relation_mention_features t1
      WHERE t0.type1 = t1.type1 AND
            t0.type2 = t1.type2;
  """
  dependencies : ["ext_relation_mention_positive", "ext_relation_mention_negative"]
  style: "sql_extractor"
}
```

**Query result:** non-training relation mentions, e.g.:

                  doc_id              |                    mid1                    |                    mid2                    |  word1  |   word2    |              rel             | bool 
    ----------------------------------+--------------------------------------------+--------------------------------------------+---------+------------+------------------------------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1015_1025 | defense | washington | org:LOCATION_of_headquarters | 
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1065_1072 | defense | tuesday    | org:founded                  | 
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1135_1139 | defense | iran       | org:LOCATION_of_headquarters |

Now that we have written our extractors, let us see how we can debug them without having to repeatedly run DeepDive.

## Debugging extractors

It is useful to debug each extractor individually without running the DeepDive system every time. To make this easier, a general debug extractor is provided in `udf/util/dummy_extractor.py`. This extractor produces a file from the SQL input query to allow the user to directly pipe that file into the desired extractor. Run the dummy extractor once to produce the sample file, and then debug the extractor by looking at the output without running the DeepDive pipeline.

For example, consider a scenario where we want to debug the entity mention extractor, `ext_mention`. We can first run `ext_mention_debug` to produce a sample TSV file, `udf/sample_data/ext_mention_sample_data.tsv`.

Refer to [DeepDive's pipeline functionality](http://deepdive.stanford.edu/doc/pipelines.html) to see how to run the system with only a particular extractor. We can specify something like the following in `application.conf`:

    pipeline.run: "debug_mention_ext"
    pipeline.pipelines.debug_mention_ext: ["ext_mention_debug"]

After running run.sh, this file can then be piped into the extractor we wish to debug, `udf/ext_mention.py`:

    >> cat $APP_HOME/udf/sample_data/ext_mention_sample_data.tsv | python $APP_HOME/udf/ext_mention.py

This process allows for interactive debugging of the extractors.

Note that if you change the inut SQL query to an extractor, you will also need to change it in the debug version of that extractor.

The code for `ext_mention_debug` is commented out in `application.conf`; similar code is also provided for `ext_relation_mention_feature_wordseq` and `ext_relation_mention_feature_deppath`.

Now that we have our extractors, let's see how we can write the inference rules.

## Writing inference rules

Now we need to tell DeepDive how to generate a factor graph to perform probabilistic inference. We want to predict the `is_correct` column of the `relation_mentions` table based on the features we have extracted, by assigning each feature a weight that DeepDive will learn.

This inference rule is defined in `application.conf` as follows:

```bash
relation_mention_lr {
  input_query: """
    SELECT t0.doc_id AS "distribute.key",
           t0.id AS "relation_mentions.id",
           t0.is_correct AS "relation_mentions.is_correct",
           t0.rel || '_' || t1.feature AS "feature"
    FROM relation_mentions t0,
         relation_mention_features t1
    WHERE t0.doc_id = t1.doc_id AND
          t0.mid1 = t1.mid1 AND
          t0.mid2 = t1.mid2;
  """
  function: "IsTrue(relation_mentions.is_correct)"
  weight: "?(feature)"
}
```

This rule generates a model similar to a logistic regression classifier. For each row in the input query we are adding a factor that connects to the `relation_mentions.is_correct` variable with a different weight for each feature name.
