#! /bin/bash

###
### RELATION EXTRACTION EVALUATION
###

export APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DEEPDIVE_HOME="$( cd $APP_HOME && cd ../..  && pwd )"

source "$APP_HOME/env.sh"
source "$APP_HOME/env_db.sh"


echo "Analyzing tables..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE relation_mentions;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE coref_candidates;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE dd_inference_result_variables;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE el_features_highprec;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE entities;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    ANALYZE mentions;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
   ANALYZE ea;
"""


echo "CREATE TABLE relation_extraction_evaluation_nofreebase..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP TABLE IF EXISTS relation_extraction_evaluation_nofreebase;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    CREATE TABLE relation_extraction_evaluation_nofreebase AS
        SELECT DISTINCT ON (t3.text, t5.type, t0.rel, t7.word, t7.type)
            t3.text                   AS entity_name, 
            t5.type                   AS entity_type, 
            t0.rel                    AS relation, 
            t7.word                   AS slot_value_name, 
            t7.type                   AS slot_value_type, 
            t3.fid                    AS entity_id, 
            t5.doc_id                 AS doc_id, 
            t6.sentence_index         AS sentence_index, 
            0                         AS entity_token_begin, 
            1                         AS entity_token_length, 
            0                         AS slot_value_token_begin, 
            1                         AS slot_value_token_length, 
            t6.character_offset_begin AS char_begin, 
            t6.character_offset_end   AS char_end, 
            t0.expectation            AS score, 
            t6.text                   AS sentence, 
            t6.words                  AS words, 
            ''::text                  AS slot_value_id
        FROM 
            relation_mentions_is_correct_inference t0, 
            el_features_highprec t1, 
            entities t3,  
            mentions t5, 
            sentence t6, 
            mentions t7
        WHERE 
            t0.doc_id = t7.doc_id AND
            t0.doc_id = t5.doc_id AND
            t0.doc_id = t6.doc_id AND
            t0.doc_id = t1.doc_id AND
            t0.mid1=t1.mention_id AND  
            t1.fid = t3.fid AND  
            t7.mention_id=t0.mid2 AND
            t5.mention_id=t0.mid1 AND 
            t5.sentence_id=t6.sentence_id AND
            t0.rel<>'per:title' AND
            t0.expectation > 0.9
    
    ORDER BY t3.text, t5.type, t0.rel, t7.word, t7.type, t0.expectation DESC
;"""


echo "CREATE TABLE relation_extraction_evaluation_nofreebase2..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    INSERT INTO relation_extraction_evaluation_nofreebase 
        SELECT DISTINCT ON (t0.word1, t5.type, t0.rel, t7.word, t7.type)
            t0.word1                   AS entity_name, 
            t5.type                   AS entity_type, 
            t0.rel                    AS relation, 
            t7.word                   AS slot_value_name, 
            t7.type                   AS slot_value_type, 
            ''::text                  AS entity_id, 
            t5.doc_id                 AS doc_id, 
            t6.sentence_index         AS sentence_index, 
            0                         AS entity_token_begin, 
            1                         AS entity_token_length, 
            0                         AS slot_value_token_begin, 
            1                         AS slot_value_token_length, 
            t6.character_offset_begin AS char_begin, 
            t6.character_offset_end   AS char_end, 
            t0.expectation            AS score, 
            t6.text                   AS sentence, 
            t6.words                  AS words, 
            ''::text                    AS slot_value_id
        FROM 
            relation_mentions_is_correct_inference t0, 
            mentions t5, 
            sentence t6, 
            mentions t7
        WHERE 
            t0.doc_id = t7.doc_id AND
            t0.doc_id = t5.doc_id AND
            t0.doc_id = t6.doc_id AND
            t7.mention_id=t0.mid2 AND
            t5.mention_id=t0.mid1 AND 
            t5.sentence_id=t6.sentence_id AND
            t0.expectation > 0.9
    ORDER BY t0.word1, t5.type, t0.rel, t7.word, t7.type, t0.expectation DESC
;"""


echo "DROP VIEW IF EXISTS coref_relation_mentions_is_correct_inference..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP VIEW IF EXISTS coref_relation_mentions_is_correct_inference;
"""

echo "CREATE VIEW coref_relation_mentions_is_correct_inference..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
   CREATE VIEW coref_relation_mentions_is_correct_inference AS
    SELECT t0.id,
           t0.doc_id,
           t0.mid1,
           t0.mid2,
           t2.word AS word1,
           t0.word2,
           t0.rel,
           t0.is_correct,
           t0.category,
           t0.expectation
      FROM relation_mentions_is_correct_inference t0,
           coref_candidates t1,
           mentions t2
     WHERE t0.doc_id = t1.doc_id AND
           t0.doc_id = t2.doc_id AND
           t0.mid1 = t1.mid1 AND
           t1.mid2 = t2.mention_id;
"""

echo "INSERT INTO relation_extraction_evaluation_nofreebase..."
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    INSERT INTO relation_extraction_evaluation_nofreebase 
        SELECT DISTINCT ON (t0.word1, t5.type, t0.rel, t7.word, t7.type)
            t0.word1                   AS entity_name, 
            t5.type                   AS entity_type, 
            t0.rel                    AS relation, 
            t7.word                   AS slot_value_name, 
            t7.type                   AS slot_value_type, 
            ''::text                  AS entity_id, 
            t5.doc_id                 AS doc_id, 
            t6.sentence_index         AS sentence_index, 
            0                         AS entity_token_begin, 
            1                         AS entity_token_length, 
            0                         AS slot_value_token_begin, 
            1                         AS slot_value_token_length, 
            t6.character_offset_begin AS char_begin, 
            t6.character_offset_end   AS char_end, 
            t0.expectation            AS score, 
            t6.text                   AS sentence, 
            t6.words                  AS words, 
            ''::text                    AS slot_value_id
        FROM 
            coref_relation_mentions_is_correct_inference t0, 
            mentions t5, 
            sentence t6, 
            mentions t7
        WHERE 
            t0.doc_id = t7.doc_id AND
            t0.doc_id = t5.doc_id AND
            t0.doc_id = t6.doc_id AND
            t7.mention_id = t0.mid2 AND
            t5.mention_id = t0.mid1 AND 
            t5.sentence_id = t6.sentence_id AND
            t0.expectation > 0.9
    ORDER BY t0.word1, t5.type, t0.rel, t7.word, t7.type, t0.expectation DESC
;"""



#psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
#    INSERT INTO relation_extraction_evaluation_nofreebase 
#        SELECT DISTINCT ON (t0.word1, t5.type, t0.rel, t7.word, t7.type)
#            t0.word1                   AS entity_name, 
#            t5.type                   AS entity_type, 
#            t0.rel                    AS relation, 
#            t7.word                   AS slot_value_name, 
#            t7.type                   AS slot_value_type, 
#            ''::text                    AS entity_id, 
#            t5.doc_id                 AS doc_id, 
#            t6.sentence_index         AS sentence_index, 
#            0                         AS entity_token_begin, 
#            1                         AS entity_token_length, 
#            0                         AS slot_value_token_begin, 
#            1                         AS slot_value_token_length, 
#            t6.character_offset_begin AS char_begin, 
#            t6.character_offset_end   AS char_end, 
#            1::float                  AS score, 
#            t6.text                   AS sentence, 
#            t6.words                  AS words, 
#            ''::text                    AS slot_value_id
#        FROM 
#            rs_with_purned_features t0, 
#            mentions t5, 
#            sentence t6, 
#            mentions t7
#        WHERE 
#            t0.doc_id = t7.doc_id AND
#            t0.doc_id = t5.doc_id AND
#            t0.doc_id = t6.doc_id AND
#            t7.mention_id=t0.mid2 AND
#            t5.mention_id=t0.mid1 AND 
#            t5.sentence_id=t6.sentence_id 
#    ORDER BY t0.word1, t5.type, t0.rel, t7.word, t7.type DESC
#;"""



echo "INSERT INTO relation_extraction_evaluation_nofreebase"
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    INSERT INTO relation_extraction_evaluation_nofreebase 
        SELECT DISTINCT ON (t3.text, t5.type, t0.rel, t0.word2)
            t3.text                   AS entity_name, 
            t5.type                   AS entity_type, 
            t0.rel                    AS relation, 
            t0.word2                  AS slot_value_name, 
            'TITLE'                   AS slot_value_type, 
            t3.fid                    AS entity_id, 
            t5.doc_id                 AS doc_id, 
            t6.sentence_index         AS sentence_index, 
            0                         AS entity_token_begin, 
            1                         AS entity_token_length, 
            0                         AS slot_value_token_begin, 
            1                         AS slot_value_token_length, 
            t6.character_offset_begin AS char_begin, 
            t6.character_offset_end   AS char_end, 
            t0.expectation            AS score, 
            t6.text                   AS sentence, 
            t6.words                  AS words, 
            t0.word2                  AS slot_value_id
        FROM 
            relation_mentions_is_correct_inference t0, 
            el_features_highprec t1,  
            entities t3,  
            mentions t5, 
            sentence t6
        WHERE 
            t0.doc_id = t5.doc_id AND
            t0.doc_id = t6.doc_id AND
            t0.doc_id = t1.doc_id AND
            t0.mid1 = t1.mention_id AND  
            t1.fid = t3.fid AND 
            t5.mention_id = t0.mid1 AND 
            t5.sentence_id = t6.sentence_id AND
            t0.rel = 'per:title' AND
            t0.word2 <> 'father' AND t0.word2 <> 'brother' AND t0.word2 <> 'host president' AND t0.word2 <> 'sister' AND
            t0.expectation > 0.9
    ORDER BY t3.text, t5.type, t0.rel, t0.word2, t0.expectation DESC
;"""


echo "CREATE TABLE relation_extraction_evaluation_non_locations"
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP TABLE IF EXISTS relation_extraction_evaluation_non_locations;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    CREATE TABLE relation_extraction_evaluation_non_locations AS
        SELECT  entity_name, 
                entity_type,
                CASE WHEN relation LIKE 'per:employee_or_member_of' AND entity_type LIKE 'PERSON' THEN 'per:employee_of'
                     WHEN relation LIKE 'org:founded_by' THEN 'org:top_members/employees'
                     ELSE relation
                END AS relation,
                slot_value_name, 
                slot_value_type, 
                entity_id, 
                doc_id, 
                sentence_index, 
                entity_token_begin, 
                entity_token_length, 
                slot_value_token_begin, 
                slot_value_token_length, 
                char_begin, 
                char_end, 
                score, 
                sentence, 
                words, 
                slot_value_id
        FROM relation_extraction_evaluation_nofreebase
        WHERE relation NOT LIKE '%LOCATION%' 
;"""


echo "CREATE TABLE relation_extraction_evaluation_locations"
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP TABLE IF EXISTS relation_extraction_evaluation_locations;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    CREATE TABLE relation_extraction_evaluation_locations AS
        SELECT *
        FROM  relation_extraction_evaluation_nofreebase
        WHERE relation LIKE '%LOCATION%' 
;"""


# if _of_residence_, then want plural
# echo "CREATE TABLE relation_extraction_evaluation_locations_updated"
# date
# psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
#     DROP TABLE IF EXISTS relation_extraction_evaluation_locations_updated;

#     CREATE TABLE relation_extraction_evaluation_locations_updated AS
#         SELECT  entity_name, 
#                 entity_type,

#                 CASE WHEN relation LIKE '%_of_residence' AND (freebase.fid LIKE 'base.location.countries' OR
#                           freebase.fid LIKE 'base.place.country' OR
#                           freebase.fid LIKE 'location.country')
#                         THEN replace(relation, 'LOCATION', 'countries')
#                      WHEN relation NOT LIKE '%_of_residence' AND (freebase.fid LIKE 'base.location.countries' OR
#                           freebase.fid LIKE 'base.place.country' OR
#                           freebase.fid LIKE 'location.country')
#                         THEN replace(relation, 'LOCATION', 'country')
#                      WHEN relation LIKE '%_of_residence' AND (freebase.fid LIKE 'base.locations.cities_and_towns' OR
#                           freebase.fid LIKE 'location.citytown')
#                         THEN replace(relation, 'LOCATION', 'cities')
#                     WHEN relation NOT LIKE '%_of_residence' AND (freebase.fid LIKE 'base.locations.cities_and_towns' OR
#                           freebase.fid LIKE 'location.citytown')
#                         THEN replace(relation, 'LOCATION', 'city')
#                      WHEN relation LIKE '%_of_residence' AND (freebase.fid LIKE 'location.province' OR
#                           freebase.fid LIKE 'base.locations.states_and_provences')
#                         THEN replace(relation, 'LOCATION', 'stateorprovinces')
#                      WHEN relation NOT LIKE '%_of_residence' AND (freebase.fid LIKE 'location.province' OR
#                           freebase.fid LIKE 'base.locations.states_and_provences')
#                         THEN replace(relation, 'LOCATION', 'stateorprovince')
#                      ELSE relation
#                 END AS relation,

#                 slot_value_name, 
#                 slot_value_type, 
#                 entity_id, 
#                 doc_id, 
#                 sentence_index, 
#                 entity_token_begin, 
#                 entity_token_length, 
#                 slot_value_token_begin, 
#                 slot_value_token_length, 
#                 char_begin, 
#                 char_end, 
#                 score, 
#                 sentence, 
#                 words, 
#                 slot_value_id
#           FROM  relation_extraction_evaluation_locations,
#                 freebase
#           WHERE freebase.slot = slot_value_id AND
#                 freebase.type LIKE 'type.type.instance' AND
#                 (freebase.fid LIKE 'base.location.countries' OR
#                     freebase.fid LIKE 'base.place.country' OR
#                     freebase.fid LIKE 'location.country' OR
#                     freebase.fid LIKE 'base.locations.cities_and_towns' OR
#                     freebase.fid LIKE 'location.citytown' OR
#                     freebase.fid LIKE 'location.province' OR
#                     freebase.fid LIKE 'base.locations.states_and_provences')
# ;"""


echo "CREATE TABLE relation_extraction_evaluation_new"
date
psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP TABLE IF EXISTS relation_extraction_evaluation_new2;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    DROP TABLE IF EXISTS relation_extraction_evaluation_new;
"""

psql -p $PGPORT -h $PGHOST -U $PGUSER $DBNAME -c """
    CREATE TABLE relation_extraction_evaluation_new2 AS
        SELECT * from relation_extraction_evaluation_non_locations;

    CREATE TABLE relation_extraction_evaluation_new AS
        SELECT DISTINCT ON (entity_name, relation, slot_value_name) *
          FROM relation_extraction_evaluation_new2
          ORDER BY entity_name, relation, slot_value_name, score DESC;
;"""


    # CREATE TABLE relation_extraction_evaluation_new2 AS
    #     (SELECT * from relation_extraction_evaluation_locations_updated) UNION ALL
    #     (SELECT * from relation_extraction_evaluation_non_locations);



# run the RE evaluation script
PGUSER=${PGUSER} PGHOST=${PGHOST} PGPORT=${PGPORT} DBNAME=${DBNAME} source $APP_HOME/evaluation/slotfilling/evaluate.sh 2010
