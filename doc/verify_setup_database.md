---
layout: default
---

Verifying setup_database.sh
====

To verify that the script `setup_database.sh` loaded the initial data properly, run the following commands and make sure that your output matches what is shown:

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
        
    >> psql $DBNAME -c "SELECT count(*) from sentence"

     count 
    -------
     70805
    (1 row)

    >> psql $DBNAME -c "SELECT doc_id, text FROM sentence ORDER BY doc_id DESC LIMIT 1"

                  doc_id              |                               text                               
    ----------------------------------+------------------------------------------------------------------
     XIN_ENG_20081231.0235.LDC2009T13 | Ms Leslie Dillingham, for voluntary service to equestrian sport. 
    (1 row)

    >> psql $DBNAME -c "SELECT count(*) from kb"
        
      count  
    ---------
     4365218
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM kb ORDER BY eid1 DESC LIMIT 1"
    
       eid1    |          rel          |  eid2   
    -----------+-----------------------+---------
     m.0zzztgd | per:LOCATION_of_birth | m.013yq
    (1 row)
        
    >> psql $DBNAME -c "SELECT count(*) from entities"

      count  
    ---------
     5000577
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM entities ORDER BY fid DESC LIMIT 1"
    
        fid    |    text    |     type      
    -----------+------------+---------------
     m.0z_zzw5 | joe browne | people.person
    (1 row)

    >> psql $DBNAME -c "SELECT count(*) from fbalias"

      count  
    ---------
     1403565
    (1 row)

    >> psql $DBNAME -c "SELECT * FROM fbalias ORDER BY fid DESC LIMIT 1"

        fid    |        type        |        slot         
    -----------+--------------------+---------------------
     m.0zzztgd | common.topic.alias | tarik hobson milner
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