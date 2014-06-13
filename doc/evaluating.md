---
layout: default
---

Evaluating the results
====

This example contains scorers for both the 2010 TAC KBP [slot filling](http://surdeanu.info/kbp2014/KBP2014_TaskDefinition_EnglishSlotFilling_1.1.pdf) as well as the 2010 TAC KBP [entity linking](http://nlp.cs.rpi.edu/kbp/2014/KBP2014EL_V0.2.pdf) tasks.

The example system will not achieve a high score on either task because our sample of 70805 sentences is only 0.2% of the full corpus.

# Entity linking

To get the entity linking score, type in:

    >> sh evaluate_entitylinking.sh

    ...
    Micro-averages:
    2250 queries: 0.5467
    1020 KB: 0.0000
    1230 NIL: 1.0000

    Macro-averages:
    871 entities: 0.5385
    402 KB: 0.0000
    469 NIL: 1.0000

Note that the score of ~0.54 is due to the system producing NIL for all of the entities because it cannot find mentions for the query entities in 0.2% of the text data (hence the 0.0000 numbers for both KB averages).

# Slot filling

To get the slot filling score, type in:

    >> sh evaluate_slotfilling.sh
    ...
    
    TODO: fill in!

Note that the results may vary across runs.

We observe a precision of XX.X (human agreement rate is around 70), and low recall since our sample is 0.2% of the full corpus.

For the ease of error analysis, we also include a relational-form of the ground truth. To see the ground truth, type in:

    >> source env_db.sh 
    >> psql $DBNAME -c "SELECT DISTINCT ON (sub) * FROM ea ORDER BY sub DESC limit 10;"

     query |        sub        |           rel           |        obj         
    -------+-------------------+-------------------------+--------------------
     SF279 | trista sutter     | per:alternate_names     | trista
     SF245 | susan boyle       | per:country_of_birth    | scotland
     SF282 | steve mcpherson   | per:title               | president
     SF285 | spencer pratt     | per:title               | manager
     SF274 | simon cowell      | per:cities_of_residence | london
     SF284 | sean preston      | per:age                 | three
     SF216 | samsung           | org:founded_by          | lee byung- chull
     SF296 | robert morgenthau | per:member_of           | navy
     SF276 | richard lindzen   | per:alternate_names     | richard s. lindzen
     SF268 | raul castro       | per:date_of_birth       | june 3, 1931
    (10 rows)


Now that we have set up the application and have run it end to end, let's look at how to [write extractors](writing_extractors.md).