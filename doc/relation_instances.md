---
layout: default
---

Extracting entity-level relation candidates
====

We want the system to produce a knowledge base at the entity level, so we need to generate a table of *(entity1, relation, entity2)* candidates (we will refer to these as relation instances). We want DeepDive to infer the probability of each candidate instance being correct, so we will add another set of random variables into our factor graph. Each of the relation instances will have NULL in the `is_correct` column, meaning that DeepDive will treat it as a random variable and will perform inference on it.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_instance_candidates {
  sql: """
    DROP TABLE IF EXISTS relation_instances CASCADE;

    CREATE TABLE relation_instances AS
             SELECT  DISTINCT
                     subj_link.entity_id      AS subject_id,
                     obj_link.entity_id       AS object_id,
                     mentions.rel             AS rel,
                     null::boolean            AS is_correct,
                     null::bigint             AS id
                FROM relation_mentions mentions,
                     el_candidate_link_2 subj_link,
                     el_candidate_link_2 obj_link
               WHERE subj_link.doc_id = mentions.doc_id AND
                     obj_link.doc_id = mentions.doc_id AND
                     subj_link.mention_id = mentions.mid1  AND
                     obj_link.mention_id  = mentions.mid2 AND
                     obj_link.entity_id <> 'NIL0000' AND
                     subj_link.entity_id <> 'NIL0000';
  """
  style: "sql_extractor"
  dependencies: ["el_round1", "ext_relation_mention", "ext_relation_mention_feature_wordseq",
                 "ext_relation_mention_feature_deppath"]
}
```

**Query result:** non-training relation mentions, e.g.:
	



Now that we have written our extractors, let us see how we can [debug them](debugging_extractors.md) without having to repeatedly run DeepDive.