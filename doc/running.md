Running KBP application
====

TODO: update the output

Make sure you are in the `kbp` directory. To run the application, type in:

    >> time sh run.sh
    ...
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [profiler] INFO  Summary Report
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [profiler] INFO  ext_cleanup SUCCESS [251 ms]
    04:26:09 [profiler] INFO  ext_mention SUCCESS [16997 ms]
    04:26:09 [profiler] INFO  ext_coref_candidate SUCCESS [2399 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_feature_deppath SUCCESS [34105 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_feature SUCCESS [63297 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_person SUCCESS [67563 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_organization SUCCESS [2258 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_title SUCCESS [3781 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_title2 SUCCESS [5060 ms]
    04:26:09 [profiler] INFO  ext_el_feature_extstr_location SUCCESS [8089 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_person SUCCESS [23261 ms]
    04:26:09 [profiler] INFO  ext_el_feature_coref SUCCESS [24390 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_title SUCCESS [32075 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_location SUCCESS [44660 ms]
    04:26:09 [profiler] INFO  ext_el_feature_alias_organization SUCCESS [48183 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_positive SUCCESS [33341 ms]
    04:26:09 [profiler] INFO  ext_relation_mention_negative SUCCESS [189 ms]
    04:26:09 [profiler] INFO  ext_relation_mention SUCCESS [3606 ms]
    04:26:09 [profiler] INFO  inference_grounding SUCCESS [16311 ms]
    04:26:09 [profiler] INFO  inference SUCCESS [47145 ms]
    04:26:09 [profiler] INFO  calibration plot written to /Users/czhang/Desktop/dd2/deepdive/out/2014-05-22T042159/calibration/relation_mentions.is_correct.png [0 ms]
    04:26:09 [profiler] INFO  calibration SUCCESS [14562 ms]
    04:26:09 [profiler] INFO  --------------------------------------------------
    04:26:09 [taskManager] INFO  Completed task_id=report with Success(Success(()))
    04:26:09 [profiler] DEBUG ending report_id=report
    04:26:09 [taskManager] INFO  1/1 tasks eligible.
    04:26:09 [taskManager] INFO  Tasks not_eligible: Set()
    04:26:09 [taskManager] DEBUG Sending task_id=shutdown to Actor[akka://deepdive/user/taskManager#1841581299]
    04:26:09 [profiler] DEBUG starting report_id=shutdown
    04:26:09 [EventStream] DEBUG shutting down: StandardOutLogger started
    Not interrupting system thread Thread[process reaper,10,system]
    [success] Total time: 251 s, completed May 22, 2014 4:26:09 AM
        
    real  4m15.001s
    user  2m30.093s
    sys 0m26.283s

To see some example results, type in:

    >> source env_db.sh
    >> psql $DBNAME -c "select word1, word2, rel from relation_mentions_is_correct_inference where rel = 'per:title' order by expectation desc limit 10;"
              word1          |   word2    |    rel    
    -------------------------+------------+-----------
     jose eduardo dos santos | president  | per:title
     kevin stallings         | coach      | per:title
     anthony hamilton        | father     | per:title
     karyn bosnak            | author     | per:title
     mahmoud ahmadinejad     | president  | per:title
     fulgencio batista       | dictator   | per:title
     raul castro             | president  | per:title
     dean spiliotes          | consultant | per:title
     simon cowell            | judge      | per:title
     castro                  | elder      | per:title
    (10 rows)

These results are the highest-confidence *(mention1, relation, mention2)* tuples produced by the system where the relation is 'per:title'. We can see that the system seems to do well at identifying people's titles.