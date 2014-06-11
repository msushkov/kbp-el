#! /bin/bash

# TODO: update

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

  ALTER TABLE el_candidate_link_2_new RENAME TO el_candidate_link;
"""
if [ "$?" != "0" ]; then echo "[50] FAILED!"; exit 1; fi
