---
layout: default
---

Verifying setup_database.sh
====

To verify that the script `setup_database.sh` loaded the initial data properly, run the following commands and make sure that your output matches what is shown (we only check a subset of all the tables here):

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
        
    >> psql $DBNAME -c "SELECT count(*) from sentence"

     count 
    -------
     70805
    (1 row)

    >> psql $DBNAME -c "SELECT doc_id, text FROM sentence ORDER BY doc_id, text DESC LIMIT 1"

                  doc_id              |                                 text                                 
    ----------------------------------+----------------------------------------------------------------------
     AFP_ENG_20020206.0348.LDC2007T07 | Washington and Tehran, two longtime foes whose ties thawed after the+
                                      | September 11 terror attacks, are again at loggerheads after US      +
                                      | President George W. Bush grouped Iran with Iraq and North Korea as  +
                                      | part of an "axis of evil" in a speech to the US Congress.           +
                                      | 
    (1 row)

    >> psql $DBNAME -c "SELECT count(*) from kb"
        
      count  
    ---------
     4365218
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM kb ORDER BY eid1, rel, eid2 DESC LIMIT 1"
    
        eid1    |             rel              |   eid2   
    ------------+------------------------------+----------
     m.01000m_9 | org:LOCATION_of_headquarters | m.09c7w0
    (1 row)
        
    >> psql $DBNAME -c "SELECT count(*) from entities"

      count  
    ---------
     5000578
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM entities ORDER BY text, fid DESC LIMIT 1"
    
        fid     |          text          |     type      
    ------------+------------------------+---------------
     m.0106bkds |          maria bardahl | people.person
    (1 row)    


    >> psql $DBNAME -c "SELECT count(*) from fbalias"

      count  
    ---------
     1403565
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM fbalias ORDER BY slot, fid DESC LIMIT 1"

        fid    |        type        |         slot         
    -----------+--------------------+----------------------
     m.01vb9zb | common.topic.alias |          rita abatsi
    (1 row)    

    >> psql $DBNAME -c "SELECT count(*) from relation_types"

     count 
    -------
        26
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM relation_types ORDER BY rel DESC LIMIT 1"
    
     type1  | type2 |    rel    | is_functional 
    --------+-------+-----------+---------------
     PERSON | TITLE | per:title | f
    (1 row)

    >> psql $DBNAME -c "SELECT count(*) from incompatible_relations"

     count 
    -------
       104
    (1 row)

    >> psql -h $PGHOST -p $PGPORT $DBNAME -c "SELECT * FROM incompatible_relations ORDER BY type1, type2 DESC LIMIT 1"

            type1        |      type2       
    ---------------------+------------------
     org:alternate_names | org:subsidiaries
    (1 row)

To check the schema of any of these tables, run the following:

    >> psql $DBNAME -c "\d entities"
      Table "public.entities"
     Column | Type | Modifiers 
    --------+------+-----------
     fid    | text | 
     text   | text | 
     type   | text | 


Now that we have loaded the data properly, let's [run the system](running.md).