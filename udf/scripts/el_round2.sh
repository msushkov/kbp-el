#! /bin/bash

# TODO: update

echo "create table el_candidate_nodistinct2_round2..."
date
psql $DBNAME -c """
		DROP TABLE IF EXISTS el_candidate_nodistinct2_round2 CASCADE;

    CREATE TABLE el_candidate_nodistinct2_round2 AS
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
