Running KBP application
====

Make sure you are in the `kbp` directory. To run the application, type in:

    >> sh run.sh
    ...
    03:45:02 [profiler] INFO  --------------------------------------------------
    03:45:02 [profiler] INFO  Summary Report
    03:45:02 [profiler] INFO  --------------------------------------------------
    03:45:02 [profiler] INFO  ext_cleanup SUCCESS [314 ms]
    03:45:02 [profiler] INFO  ext_mention SUCCESS [28486 ms]
    03:45:02 [profiler] INFO  wiki_link SUCCESS [290888 ms]
    03:45:02 [profiler] INFO  wiki_redirect SUCCESS [293188 ms]
    03:45:02 [profiler] INFO  top_bing_result SUCCESS [293212 ms]
    03:45:02 [profiler] INFO  everything_nil SUCCESS [301676 ms]
    03:45:02 [profiler] INFO  exact_str_match SUCCESS [407718 ms]
    03:45:02 [profiler] INFO  ext_relation_mention_feature_deppath SUCCESS [441965 ms]
    03:45:02 [profiler] INFO  fbalias_person SUCCESS [462850 ms]
    03:45:02 [profiler] INFO  mention_text_num_words SUCCESS [467824 ms]
    03:45:02 [profiler] INFO  fbalias_location SUCCESS [8390 ms]
    03:45:02 [profiler] INFO  fbalias_title SUCCESS [11168 ms]
    03:45:02 [profiler] INFO  ext_relation_mention_feature_wordseq SUCCESS [494969 ms]
    03:45:02 [profiler] INFO  fbalias_organization SUCCESS [35173 ms]
    03:45:02 [profiler] INFO  bing_result SUCCESS [498072 ms]
    03:45:02 [profiler] INFO  el_round_1 SUCCESS [96079 ms]
    03:45:02 [profiler] INFO  consistent_types_person SUCCESS [4392 ms]
    03:45:02 [profiler] INFO  no_given_name SUCCESS [15937 ms]
    03:45:02 [profiler] INFO  no_family_name SUCCESS [19788 ms]
    03:45:02 [profiler] INFO  context SUCCESS [21099 ms]
    03:45:02 [profiler] INFO  no_time_event SUCCESS [32584 ms]
    03:45:02 [profiler] INFO  state_ambiguous SUCCESS [34845 ms]
    03:45:02 [profiler] INFO  consistent_types_location SUCCESS [33320 ms]
    03:45:02 [profiler] INFO  no_film SUCCESS [45308 ms]
    03:45:02 [profiler] INFO  city_town_ambiguous SUCCESS [45406 ms]
    03:45:02 [profiler] INFO  no_social_network_user SUCCESS [50566 ms]
    03:45:02 [profiler] INFO  dont_trust_single_name SUCCESS [91064 ms]
    03:45:02 [profiler] INFO  entity_popularity SUCCESS [97629 ms]
    03:45:02 [profiler] INFO  consistent_types_organization SUCCESS [62900 ms]
    03:45:02 [profiler] INFO  consistent_types_title2 SUCCESS [1122 ms]
    03:45:02 [profiler] INFO  consistent_types_title SUCCESS [2755 ms]
    03:45:02 [profiler] INFO  el_round_2 SUCCESS [28774 ms]
    03:45:02 [profiler] INFO  ext_relation_mention_positive SUCCESS [11183 ms]
    03:45:02 [profiler] INFO  ext_relation_mention_negative SUCCESS [170 ms]
    03:45:02 [profiler] INFO  ext_relation_mention SUCCESS [7760 ms]
    03:45:02 [profiler] INFO  ext_relation_instance_candidates SUCCESS [89707 ms]
    03:45:02 [profiler] INFO  inference_grounding SUCCESS [132017 ms]
    03:45:02 [profiler] INFO  inference SUCCESS [209790 ms]
    03:45:02 [profiler] INFO  calibration plot written to /Users/msushkov/Dropbox/Stanford/deepdive/out/2014-06-12T032411/calibration/el_candidate_link_2.is_correct.png [0 ms]
    03:45:02 [profiler] INFO  calibration plot written to /Users/msushkov/Dropbox/Stanford/deepdive/out/2014-06-12T032411/calibration/el_candidate_link.is_correct.png [0 ms]
    03:45:02 [profiler] INFO  calibration plot written to /Users/msushkov/Dropbox/Stanford/deepdive/out/2014-06-12T032411/calibration/relation_mentions.is_correct.png [0 ms]
    03:45:02 [profiler] INFO  calibration plot written to /Users/msushkov/Dropbox/Stanford/deepdive/out/2014-06-12T032411/calibration/relation_instances.is_correct.png [0 ms]
    03:45:02 [profiler] INFO  calibration SUCCESS [42412 ms]
    03:45:02 [profiler] INFO  --------------------------------------------------
    03:45:02 [taskManager] INFO  Completed task_id=report with Success(Success(()))
    03:45:02 [taskManager] INFO  1/1 tasks eligible.
    03:45:02 [taskManager] INFO  Tasks not_eligible: Set()
    Not interrupting system thread Thread[process reaper,10,system]
    [success] Total time: 1253 s, completed Jun 12, 2014 3:45:02 AM

To see some example results, type in:

    >> source env_db.sh
    >> psql $DBNAME -c "select word1, word2, rel from relation_mentions_is_correct_inference where rel = 'per:title' order by expectation, word1, word2 desc limit 10;"



These results are the highest-confidence *(entity1, relation, entity2)* tuples produced by the system where the relation is 'per:title'. We can see that the system seems to do well at identifying people's titles.


Let us now [compute a score](evaluating.md) for the 2010 KBP slot filling task.