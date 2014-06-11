Setting up KBP application
====

* [Cloning the repository](#cloning-the-repository)
* [Connecting to the database](#connecting-to-the-database)
* [Loading initial data](#loading-initial-data)


# Cloning the repository

Navigate to the folder "app" (same folder as you use in the walkthrough), 
clone this repository, and switch to the correct branch.

    >> cd app
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
	
From now on we will be working in the `kbp` directory.

# Connecting to the database

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

# Loading initial data

The initial database dump contains the following tables:
- `sentence`: contains processed sentence data by an [NLP extractor](http://deepdive.stanford.edu/doc/walkthrough-extras.html#nlp_extractor). This table contains tokenized words, lemmatized words, POS tags, NER tags, dependency paths for each sentence. The table contains 70805 sentences, which is 0.2% of the full corpus for 2010.
- `kb`: Contains tuples of the form (entity1, relation, entity2); this is the knowledge base used for distant supervision.
- `entities`: A set of entities from Freebase.
- `fbalias`: Freebase aliases for entities. An alias is an alternate name for an entity; for example, William Henry Gates III is an alias for Bill Gates.
- `relation_types`: The typed relations we care to extract.
- `incompatible_relations`: Contains tuples of the form (relation1, relation2) where relation2 is incompatible with relation1. This is used to generate negative examples (given (e1, relation1, e2), (e1, relation2, e2) will be a negative example).
- `ea`: Contains the ground truth for the evaluation; to be used for error analysis
- TODO: define additional tables

There are 3 additional tables that the system will need to create, to be used by the extractors. The tables are:
- `mentions` (populated by `ext_mention`)
- `relation_mentions` (populated by `ext_relation_mention_positive`, `ext_relation_mention_negative`, and `ext_relation_mention`)
- `relation_mention_features` (populated by `ext_relation_mention_feature`)

The first set of tables is included in the database dump, and the second 3 tables are created in `schema.sql`. The script `setup_database.sh` will load all the necessary tables into the database.

Load the initial database:

    >> sh setup_database.sh

TODO: update the output

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

For a more detailed verification of `setup_database.sh` (recommended), please see [verifying setup_database.sh](verify_setup_database.md).

Now that we have loaded all the necessary data, we can run the application.