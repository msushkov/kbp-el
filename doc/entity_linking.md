---
layout: default
---

Entity linking
====

To identify which mentions in text refer to which entities, we need to perform entity linking. This involves extracting *(entity, mention)* pairs based on different criteria (here we will refer to these criteria as rules, or features).

We will perform probabilistic entity linking - we will have a random variable for a given *(entity, mention)* pair that will tell us, after DeepDive runs, how confident the system is in the pair being linked.

At a high level, we first want to generate candidate pairs that might be linked, and then let DeepDive figure out which of these links are most likely to hold.

In this example we do entity linking in two rounds, each of which will use its own set of features to generate candidate pairs. The first round includes basic features such as exact string match, while the second round adds more sophisticated features. Here we will use the entity feature tables from our initial database.

Each of the extractors corresponds to a single entity linking rule and will create its own candidate table. At the end of each round a candidate link table will be produced by taking the union of all the rule-specific tables. We will have 2 candidate link tables at the end: `el_candidate_link`, and `el_candidate_link_2`, each of which will contain the `is_correct` column. We will perform inference on both of these columns, but ultimately will use `el_candidate_link_2` as our entity linking table to produce the entity-level relations (since this table uses `el_candidate_link`).

We will briefly go over each of the entity linking rules below.

# Round 1

## All mentions are linked to the NIL entity by default

This extractor produces the set of tuples *(entity, mention)* where entity is the NIL entity.


This extractor is defined using the following code in `application.conf`:

```bash
everything_nil {
  sql: """
      DROP TABLE IF EXISTS el_everything_nil CASCADE;

      CREATE TABLE el_everything_nil AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e"
          WHERE e.fid = 'NIL0000';
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Exact string match

This extractor produces the set of tuples *(entity, mention)* where the entity and mention text matches exactly.

This extractor is defined using the following code in `application.conf`:

```bash
exact_str_match {
  sql: """
      DROP TABLE IF EXISTS el_exact_str_match CASCADE;

      CREATE TABLE el_exact_str_match AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e"
          WHERE e.text = m.word;
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Wikipedia link

This extractor produces the set of tuples *(entity, mention)* where the entity has a Wikipedia link with the same text as the mention text.

This extractor is defined using the following code in `application.conf`:

```bash
wiki_link {
  sql: """
      DROP TABLE IF EXISTS el_wiki_link CASCADE;

      CREATE TABLE el_wiki_link AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e",
               entity_feature_wikilink AS "w"
          WHERE e.fid = w.eid1 AND
                m.word = w.featurevalue3;
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Wikipedia redirect

This extractor produces the set of tuples *(entity, mention)* where the entity has a Wikipedia redirect with the same text as the mention text.

This extractor is defined using the following code in `application.conf`:

```bash
wiki_redirect {
  sql: """
      DROP TABLE IF EXISTS el_wiki_redirect CASCADE;

      CREATE TABLE el_wiki_redirect AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e",
               entity_feature_wikiredirect AS "w"
          WHERE e.fid = w.eid1 AND
                m.word = w.featurevalue2;
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Top search result

This extractor produces the set of tuples *(entity, mention)* where the entity's Wikipedia page comes up as the top search engine result when searching for the mention text.

This extractor is defined using the following code in `application.conf`:

```bash
top_search_engine_result {
  sql: """
      DROP TABLE IF EXISTS el_top_search_engine_result CASCADE;

      CREATE TABLE el_top_search_engine_result AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e",
               entity_feature_bing_query AS "q",
               el_kbp_eval_query AS "eval"
          WHERE e.fid = q.eid2 AND
                q.query1 = m.word AND
                m.word = eval.text AND
                m.doc_id = eval.doc_id AND
                q.rank3 = '1';
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Search result

This extractor produces the set of tuples *(entity, mention)* where the entity's Wikipedia page comes up as some search engine result when searching for the mention text.

This extractor is defined using the following code in `application.conf`:

```bash
search_engine_result {
  sql: """
      DROP TABLE IF EXISTS el_search_engine_result CASCADE;

      CREATE TABLE el_search_engine_result AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e",
               entity_feature_bing_query AS "q",
               el_kbp_eval_query AS "eval"
          WHERE e.fid = q.eid2 AND
                q.query1 = m.word AND
                m.word = eval.text AND
                m.doc_id = eval.doc_id AND
                q.rank3 IS NOT NULL;
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Freebase alias

This extractor produces the set of tuples *(entity, mention)* where the entity has a Freebase alias that exactly matches the mention text. This rule is defined for the PERSON, ORGANIZATION, LOCATION, and TITLE entity and mention types; for conciseness we include only the PERSON rule.

This extractor is defined using the following code in `application.conf`:

```bash
fbalias_person {
  sql: """
      DROP TABLE IF EXISTS el_fbalias CASCADE;

      CREATE TABLE el_fbalias AS
        SELECT DISTINCT
              m.doc_id AS "doc_id",
              m.mention_id AS "mention_id",
              e.fid AS "entity_id"
          FROM mentions AS "m",
               entities AS "e",
               fbalias AS "f"
          WHERE m.type = 'PERSON' AND
                e.type = 'people.person' AND
                m.word = f.slot AND
                e.fid = f.fid AND
                m.word LIKE '% %';
    """
  style: "sql_extractor"
  dependencies: ["ext_mention"]
}
```

## Combine all round 1 rules into `el_candidate_link`

This extractor produces the `el_candidate_link` table, which is the union of all the round 1 candidate tables. Note that in order to avoid linking mentions to a large amount of irrelevant entities, we limit the candidates to only include mentions that link to less than NUM_ENTITIES_PER_MENTION entities (this environment variable is defined in `env.sh`).

This extractor is defined using the following code in `application.conf` and in `udf/scripts/el_round1.sh`:

```bash
el_round_1 {
  cmd: ${APP_HOME}"/udf/scripts/el_round1.sh"
  style: "cmd_extractor"
  dependencies: ["everything_nil", "exact_str_match", "wiki_link", "wiki_redirect",
                 "top_bing_result", "bing_result", "fbalias_person", "fbalias_location",
                 "fbalias_organization", "fbalias_title"]
}
```

```bash
#! /bin/bash

echo "create table el_candidate_nodistinct2..."
date
psql $DBNAME -c """
    DROP TABLE IF EXISTS el_candidate_nodistinct2 CASCADE;

    CREATE TABLE el_candidate_nodistinct2 AS
      SELECT * from el_everything_nil;
"""
if [ "$?" != "0" ]; then echo "[1] FAILED!"; exit 1; fi

echo "insert into el_candidate_nodistinct2..."
date
psql $DBNAME -c """
  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_exact_str_match;

  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_wiki_link;

  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_wiki_redirect;

  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_top_bing_result;

  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_bing_result;

  INSERT INTO el_candidate_nodistinct2
    SELECT * from el_fbalias;
"""
if [ "$?" != "0" ]; then echo "[10] FAILED!"; exit 1; fi

echo "create table el_candidate_link..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link CASCADE;

  CREATE TABLE el_candidate_link AS
    SELECT doc_id,
           entity_id,
           mention_id
    FROM el_candidate_nodistinct2
    GROUP BY entity_id, mention_id, doc_id;
"""
if [ "$?" != "0" ]; then echo "[20] FAILED!"; exit 1; fi

echo "create table el_candidate_link_pruned..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link_pruned CASCADE;
  DROP TABLE IF EXISTS el_candidate_link_new CASCADE;

  CREATE TABLE el_candidate_link_pruned AS
    SELECT doc_id,
           mention_id,
           count(entity_id) as c 
      FROM el_candidate_link 
      GROUP BY doc_id, mention_id 
      HAVING count(entity_id) < """${NUM_ENTITIES_PER_MENTION}""";
"""
if [ "$?" != "0" ]; then echo "[30] FAILED!"; exit 1; fi

echo "create table el_candidate_link_new..."
date
psql $DBNAME -c """
  CREATE TABLE el_candidate_link_new AS
    SELECT link1.doc_id AS doc_id,
           link1.entity_id AS entity_id,
           link1.mention_id AS mention_id,
           null::boolean AS is_correct,
           null::bigint AS id
      FROM el_candidate_link link1,
           el_candidate_link_pruned link2
      WHERE link1.doc_id = link2.doc_id AND
            link1.mention_id = link2.mention_id;
"""
if [ "$?" != "0" ]; then echo "[40] FAILED!"; exit 1; fi

echo "el_candidate_link..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link CASCADE;
  DROP TABLE IF EXISTS el_candidate_link_pruned CASCADE;
  DROP TABLE IF EXISTS el_candidate_nodistinct2 CASCADE;

  ALTER TABLE el_candidate_link_new RENAME TO el_candidate_link;
"""
if [ "$?" != "0" ]; then echo "[50] FAILED!"; exit 1; fi
```



# Round 2

## Consistent types

This extractor produces the set of tuples *(entity, mention)* from `el_candidate_link` where the entity and mention have the same types. This rule is defined for the PERSON, ORGANIZATION, LOCATION, and TITLE entity and mention types; for conciseness we include only the PERSON rule.

This extractor is defined using the following code in `application.conf`:

consistent_types_person {
  sql: """
      DROP TABLE IF EXISTS el_consistent_types;

      CREATE TABLE el_consistent_types AS
        SELECT DISTINCT
              link.doc_id AS "doc_id",
              link.mention_id AS "mention_id",
              link.entity_id AS "entity_id"
          FROM el_candidate_link AS "link",
               mentions AS "m",
               entities AS "e"
          WHERE link.doc_id = m.doc_id AND
                link.entity_id = e.fid AND
                link.mention_id = m.mention_id AND
                m.type = 'PERSON' AND
                e.type = 'people.person';
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Break ties using the more popular entity

Given 2 entities (entity and entity2) that link to the same mention in `el_candidate_link`, this extractor produces the set of tuples *(entity, mention)* where entity has the highest popularity, and entity2 does not have the highest popularity (a popularity of 80 is the highest).

This extractor is defined using the following code in `application.conf`:

entity_popularity {
  sql: """
      DROP TABLE IF EXISTS el_entity_popularity;

      CREATE TABLE el_entity_popularity AS
        SELECT DISTINCT
             link1.doc_id AS "doc_id",
             link1.mention_id AS "mention_id",
             link1.entity_id AS "entity_id" 
        FROM el_candidate_link AS "link1",
             el_candidate_link AS "link2",
             entities AS "e1",
             entities AS "e2",
             entity_feature_popularity AS "pop1",
             entity_feature_popularity AS "pop2"
        WHERE link1.entity_id = e1.fid AND
              link2.entity_id = e2.fid AND
              link1.mention_id = link2.mention_id AND
              e1.fid <> e2.fid AND
              e1.fid = pop1.eid1 AND
              e2.fid = pop2.eid1 AND
              pop1.featurevalue2 = '80' AND
              pop2.featurevalue2 <> '80';
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Don't trust a single first/last name

Given a candidate link *(entity, mention)* in `el_candidate_link`, if the mention is of the PERSON type and consists of a single word, link the mention to the NIL entity.

This extractor is defined using the following code in `application.conf`:

dont_trust_single_name {
  sql: """
      DROP TABLE IF EXISTS el_dont_trust_single_name;

      CREATE TABLE el_dont_trust_single_name AS
        SELECT DISTINCT
             link.doc_id AS "doc_id",
             link.mention_id AS "mention_id",
             e_nil.fid AS "entity_id" 
        FROM el_candidate_link AS "link",
             entities AS "e",
             mentions AS "m",
             mention_feature_text_num_words AS "num_words",
             entities AS "e_nil"
        WHERE link.doc_id = m.doc_id AND
              link.mention_id = m.mention_id AND
              link.entity_id = e.fid AND
              m.mention_id = num_words.mid AND
              m.type = 'PERSON' AND
              num_words.feature = '1' AND
              e.fid <> 'NIL0000' AND
              e_nil.fid = 'NIL0000';
    """
  style: "sql_extractor"
  dependencies: ["el_round_1", "mention_text_num_words"]
}

## Context for mentions of entities that have multiple canonical forms

This extractor produces the set of tuples *(entity, mention)* that come from `el_candidate_link`, where the entity needs de-duplication (e.g. the state Texas could be written as "Texas" or "TX") and there exists another mention in the same document that has the same text as one of the entity's canonical forms.

For example, let's say we observe the mentions "Texas" and "TX" in the same document. If the tuple *(Texas, "Texas")* or *(Texas, "TX")* is present in `el_candidate_link`, this extractor would output it.

This extractor is defined using the following code in `application.conf`:

context {
  sql: """
      DROP TABLE IF EXISTS el_context CASCADE;

      CREATE TABLE el_context AS
        SELECT DISTINCT
             link.doc_id AS "doc_id",
             link.mention_id AS "mention_id",
             link.entity_id AS "entity_id" 
        FROM el_candidate_link AS "link",
             entity_feature_need_nodup AS "need",
             mentions AS "m",
             mentions AS "m1",
             entities AS "e"
        WHERE link.doc_id = m.doc_id AND
              link.mention_id = m.mention_id AND
              link.entity_id = e.fid AND
              need.eid1 = e.fid AND
              need.word2 = m1.word AND
              m.doc_id = m1.doc_id AND
              m.sentence_id <> m1.sentence_id;
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Ambiguous cities/towns

This extractor produces the set of tuples *(entity, mention)* where entity is the NIL entity and mention refers to an entity that is a U.S. state that has a Wikipedia disambiguation page and is of type 'location.citytown'.

This extractor is defined using the following code in `application.conf`:

city_town_ambiguous {
  sql: """
      DROP TABLE IF EXISTS el_city_town_ambiguous CASCADE;

      CREATE TABLE el_city_town_ambiguous AS
        SELECT DISTINCT
               m.doc_id AS "doc_id",
               m.mention_id AS "mention_id",
               e_nil.fid AS "entity_id"
          FROM el_kbp_eval_query,
               usstate,
               entity_feature_wikidisambiguation AS "d",
               entities AS "e",
               entities AS "e_nil",
               mentions AS "m",
               entity_feature_hasneed AS "hasneed",
               freebase
          WHERE el_kbp_eval_query.text = usstate.word1 AND
                m.word = el_kbp_eval_query.text AND
                m.doc_id = el_kbp_eval_query.doc_id AND
                d.eid1 = e.fid AND
                d.featurevalue2 = usstate.word1 AND
                e.fid = hasneed.eid1 AND
                e_nil.fid = 'NIL0000' AND
                freebase.type = 'type.type.instance' AND
                freebase.fid = 'location.citytown' AND
                freebase.slot = e.fid;
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Ambiguous states

This extractor produces the set of tuples *(entity, mention)* where entity is the NIL entity and mention refers to an entity that is an ambiguous U.S. state code.

This extractor is defined using the following code in `application.conf`:

state_ambiguous {
  sql: """
      DROP TABLE IF EXISTS el_state_ambiguous CASCADE;

      CREATE TABLE el_state_ambiguous AS
        SELECT DISTINCT
               m.doc_id AS "doc_id",
               m.mention_id AS "mention_id",
               e_nil.fid AS "entity_id"
          FROM el_kbp_eval_query,
               ambcode,
               mentions AS "m",
               entities AS "e_nil"
          WHERE e_nil.fid = 'NIL0000' AND
                el_kbp_eval_query.text = m.word AND
                el_kbp_eval_query.doc_id = m.doc_id AND 
                ambcode.lower = el_kbp_eval_query.text;
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Prune certain entity types

It is impossible for entities of the following types to be present in the TAC KBP gold standard:

- /internet/social_network_user
- /time/event
- /people/family_name
- /people/family_name
- /base/givennames/given_name
- /base/wfilmbase/film

We create a set of 5 extractors, each of which produces the set of tuples *(entity, mention)* from the table `el_candidate_link` where entity has the given undesired type. We show an example only for /internet/social_network_user:

no_social_network_user {
  sql: """
      DROP TABLE IF EXISTS el_no_social_network_user CASCADE;

      CREATE TABLE el_no_social_network_user AS
        SELECT DISTINCT
               link.doc_id AS "doc_id",
               link.mention_id AS "mention_id",
               link.entity_id AS "entity_id"
          FROM el_candidate_link AS "link",
               freebase AS "f"
          WHERE link.entity_id = f.slot AND
                f.type = 'type.type.instance' AND
                f.fid = 'internet.social_network_user';
    """
  style: "sql_extractor"
  dependencies: ["el_round_1"]
}

## Combine all round 2 rules into `el_candidate_link_2`

This extractor produces the `el_candidate_link_2` table, which is the union of all the round 2 candidate tables. Note again that in order to avoid linking mentions to a large amount of irrelevant entities, we limit the candidates to only include mentions that link to less than NUM_ENTITIES_PER_MENTION entities (this environment variable is defined in `env.sh`).

This extractor is defined using the following code in `application.conf` and in `udf/scripts/el_round2.sh`:

```bash
el_round_2 {
  cmd: ${APP_HOME}"/udf/scripts/el_round2.sh"
  style: "cmd_extractor"
  dependencies: ["el_round_1", "consistent_types_person",
                 "consistent_types_location", "consistent_types_organization",
                 "consistent_types_title", "consistent_types_title2", "entity_popularity",
                 "dont_trust_single_name", "context", "city_town_ambiguous", "state_ambiguous",
                 "no_social_network_user", "no_time_event", "no_family_name", "no_given_name",
                 "no_film"]
}
```

```bash
#! /bin/bash

echo "create table el_candidate_nodistinct2_round2..."
date
psql $DBNAME -c """
    DROP TABLE IF EXISTS el_candidate_nodistinct2_round2 CASCADE;

    CREATE TABLE el_candidate_nodistinct2_round2 AS
      SELECT * from el_consistent_types;
"""
if [ "$?" != "0" ]; then echo "[1] FAILED!"; exit 1; fi


echo "insert into el_candidate_nodistinct2..."
date
psql $DBNAME -c """
  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_entity_popularity;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_dont_trust_single_name;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_context;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_city_town_ambiguous;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_state_ambiguous;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_no_social_network_user;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_no_time_event;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_no_family_name;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_no_given_name;

  INSERT INTO el_candidate_nodistinct2_round2
    SELECT * FROM el_no_film;
"""
if [ "$?" != "0" ]; then echo "[10] FAILED!"; exit 1; fi


echo "create table el_candidate_link_2..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link_2 CASCADE;

  CREATE TABLE el_candidate_link_2 AS
    SELECT doc_id,
           entity_id,
           mention_id
    FROM el_candidate_nodistinct2_round2
    GROUP BY entity_id, mention_id, doc_id;
"""
if [ "$?" != "0" ]; then echo "[20] FAILED!"; exit 1; fi


echo "create table el_candidate_link_2_pruned..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link_2_pruned CASCADE;
  DROP TABLE IF EXISTS el_candidate_link_2_new CASCADE;

  CREATE TABLE el_candidate_link_2_pruned AS
    SELECT doc_id,
           mention_id,
           count(entity_id) as c 
      FROM el_candidate_link_2
      GROUP BY doc_id, mention_id 
      HAVING count(entity_id) < """${NUM_ENTITIES_PER_MENTION}""";
"""
if [ "$?" != "0" ]; then echo "[30] FAILED!"; exit 1; fi


echo "create table el_candidate_link_2_new..."
date
psql $DBNAME -c """
  CREATE TABLE el_candidate_link_2_new AS
    SELECT link1.doc_id AS doc_id,
           link1.entity_id AS entity_id,
           link1.mention_id AS mention_id,
           null::boolean AS is_correct,
           null::bigint AS id
      FROM el_candidate_link_2 link1,
           el_candidate_link_2_pruned link2
      WHERE link1.doc_id = link2.doc_id AND
            link1.mention_id = link2.mention_id;
"""
if [ "$?" != "0" ]; then echo "[40] FAILED!"; exit 1; fi


echo "el_candidate_link_2..."
date
psql $DBNAME -c """
  DROP TABLE IF EXISTS el_candidate_link_2 CASCADE;
  DROP TABLE IF EXISTS el_candidate_link_2_pruned CASCADE;
  DROP TABLE IF EXISTS el_candidate_nodistinct2_round2 CASCADE;

  ALTER TABLE el_candidate_link_2_new RENAME TO el_candidate_link_2;
"""
if [ "$?" != "0" ]; then echo "[50] FAILED!"; exit 1; fi
```

  
    


Next, we need to [add training examples](training_data.md).