Setting up KBP application
====

* [Cloning the repository](#cloning-the-repository)
* [Connecting to the database](#connecting-to-the-database)
* [Loading initial data](#loading-initial-data)


# Cloning the repository

Navigate to the folder `app` (same folder as you use in the walkthrough) and
clone the repository:

    >> cd app
    >> git clone git@github.com:msushkov/kbp-el.git
    >> cd kbp-el

To validate this step, you should see:

    >> git branch
      * master
    >> ls
    README.md           env.sh                       evaluation           udf
    application.conf    env_db.sh                    run.sh
    data                evaluate_entitylinking.sh    schema.sql
    doc                 evaluate_slotfilling.sh      setup_database.sh

	
From now on we will be working in the `kbp-el` directory.

# Connecting to the database

Change the database settings in the file `env_db.sh`, whose original contents is:

    #! /bin/bash

    export DBNAME=deepdive_kbp_with_el_2
    export PGUSER=msushkov
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

# Loading initial data

The initial database dump contains the following tables:
- `ambcode`: Contains 25 ambiguous state codes.
- `ea`: Contains 2348 tuples which make up the ground truth for the evaluation; to be used for error analysis.
- `eid_to_fid`: Contains 811053 tuples which give a mapping between the KBP id of an entity and the Freebase id of an entity (used in entity linking evaluation).
- `el_kbp_eval_query`: Contains 2250 tuples which make up the ground truth for entity linking evaluation.
- `entities`: A set of 5000578 entities from Freebase, including the NIL entity (for entity linking - a mention could link to the NIL entity).
- `entity_feature_bing_query`: Contains 649 entity features: for a given keyword, the entity that shows up in the search results, and its results ranking.
- `entity_feature_hasneed`: Contains 116840 entities that need disambiguation.
- `entity_feature_need_nodup`: Contains 195577 entities that need deduplication.
- `entity_feature_popularity`: Contains the popularities of 725376 entities (popularity of 80 is the highest).
- `entity_feature_wikidisambiguation`: Contains 797583 Wikipedia disambiguation page titles for entities.
- `entity_feature_wikilink`: Contains 3179270 tuples that contain the anchor text and frequency of internal Wikipedia page links to entities.
- `entity_feature_wikiredirect`: Contains 1310072 Wikipedia page redirect titles for entities.
- `fbalias`: Contains 1403565 Freebase aliases for entities. An alias is an alternate name for an entity; for example, William Henry Gates III is an alias for Bill Gates.
- `freebase`: A partial dump of Freebase. Contains 10 million tuples of the form *(subject, predicate, object)*. As of spring 2014, this made up about 10% of the full Freebase dump.
- `incompatible_relations`: Contains 104 tuples of the form *(relation1, relation2)* where relation2 is incompatible with relation1. This is used to generate negative examples (given *(e1, relation1, e2)*, *(e1, relation2, e2)* will be a negative example).
- `kb`: Contains tuples of the form *(entity1, relation, entity2)*; this is the knowledge base used for distant supervision.
- `relation_types`: 26 of the typed relations we care to extract.
- `sentence`: contains processed sentence data with an [NLP extractor](http://deepdive.stanford.edu/doc/walkthrough-extras.html#nlp_extractor). This table contains tokenized words, lemmatized words, POS tags, NER tags, dependency paths for each sentence. There are 70805 sentences, which is 0.2% of the full corpus for 2010.
- `usstate`: Contains a list of the 51 U.S. states (including DC).

There are 4 additional tables that the system will need to create, to be used by the extractors. The tables are:
- `mentions` (populated by `ext_mention`)
- `relation_mentions` (populated by `ext_relation_mention_positive`, `ext_relation_mention_negative`, and `ext_relation_mention`)
- `relation_mention_features` (populated by `ext_relation_mention_feature`)
- `mention_feature_text_num_words` (populated by `mention_text_num_words`)

The first set of tables is included in the database dump, and the second set is created in `schema.sql`. The script `setup_database.sh` will load all the necessary tables into the database.

Load the initial database:

    >> sh setup_database.sh

Validate that this step succeeded as follows:

    >> source env_db.sh

    >> psql $DBNAME -c "\d"

                           List of relations
     Schema |               Name                | Type  |  Owner   
    --------+-----------------------------------+-------+----------
     public | ambcode                           | table | msushkov
     public | ea                                | table | msushkov
     public | eid_to_fid                        | table | msushkov
     public | el_kbp_eval_query                 | table | msushkov
     public | entities                          | table | msushkov
     public | entity_feature_bing_query         | table | msushkov
     public | entity_feature_hasneed            | table | msushkov
     public | entity_feature_need_nodup         | table | msushkov
     public | entity_feature_popularity         | table | msushkov
     public | entity_feature_wikidisambiguation | table | msushkov
     public | entity_feature_wikilink           | table | msushkov
     public | entity_feature_wikiredirect       | table | msushkov
     public | fbalias                           | table | msushkov
     public | freebase                          | table | msushkov
     public | incompatible_relations            | table | msushkov
     public | kb                                | table | msushkov
     public | mention_feature_text_num_words    | table | msushkov
     public | mentions                          | table | msushkov
     public | relation_mention_features         | table | msushkov
     public | relation_mentions                 | table | msushkov
     public | relation_types                    | table | msushkov
     public | sentence                          | table | msushkov
     public | usstate                           | table | msushkov
    (23 rows)

For a more detailed verification of `setup_database.sh` (recommended), please see [verifying setup_database.sh](verify_setup_database.md).

Now that we have loaded all the necessary data, we can [run the application](running.md).