---
layout: default
---

Evaluating the results
====

TODO: update

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

In this log, the precision is 62.5 (human agreement rate is around 70), and recall is low since our sample is 0.2% of the full corpus.

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