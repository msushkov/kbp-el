---
layout: default
---

Writing inference rules
====

Now we need to tell DeepDive how to generate a factor graph to perform probabilistic inference. We want ultimately to predict the `is_correct` column of the `relation_instances` table, but this output variables relies on the system's predictions for `is_correct` column of the entity linking candidates table, as well as the `is_correct` column of the `relation_mentions` table.

# Entity linking

In order to find the entity-level relations it is necessary to perform entity linking.

The example system contains a series of entity-linking inference rules, each of which is essentially doing the same thing: for each of the entity linking features extracted in the extractors, predict the value of the `is_correct` column for the subset of entity linking candidates that has that feature, using a hand-tuned weight (essentially, find how strongly the system believes that each link holds).


We have the table `el_candidate_link_2`, which contains the candidate links for all the entity linking features. Each of the features also has its own candidate table, which is a subset of el_candidate_link.

This general inference rule is defined in `application.conf` as follows:

```bash
rule_el {
  input_query: """
      SELECT link.doc_id AS "distribute.key",
             link.is_correct AS "el_candidate_link.is_correct",
             link.id AS "el_candidate_link.id"
        FROM el_candidate_link link,
             <el_feature_table> e
        WHERE link.entity_id = e.entity_id AND
              link.mention_id = e.mention_id AND
              link.doc_id = e.doc_id
    """
  function: "IsTrue(el_candidate_link.is_correct)"
  weight: <custom weight>
}
```

Refer to lines 1022 - 1394 in `application.conf` to see each of these extractors.

# Relation mentions

We also want to predict the value of the `is_correct` column of the `relation_mentions` table based on the features we have extracted, by assigning each feature a weight that DeepDive will learn.

This inference rule is defined in `application.conf` as follows:

```bash
relation_mention_lr {
  input_query: """
    SELECT t0.doc_id AS "distribute.key",
           t0.id AS "relation_mentions.id",
           t0.is_correct AS "relation_mentions.is_correct",
           t0.rel || '_' || t1.feature AS "feature"
    FROM relation_mentions t0,
         relation_mention_features t1
    WHERE t0.doc_id = t1.doc_id AND
          t0.mid1 = t1.mid1 AND
          t0.mid2 = t1.mid2;
  """
  function: "IsTrue(relation_mentions.is_correct)"
  weight: "?(feature)"
}
```

This rule generates a model similar to a logistic regression classifier. For each row in the input query we are adding a factor that connects to the `relation_mentions.is_correct` variable with a different weight for each feature name.

# Relation instances

To find the entity-level relations, we want to predict the value of the `is_correct` column of the `relation_instances` tables. The value of this column will be influenced by the values of the entity linking variables as well as the value of the mention-level variables.

This inference rule is defined in `application.conf` as follows:

```bash
input_query: """
    SELECT
        instance.subject_id AS "distribute.key",
        instance.id AS "relation_instances.id",
        instance.is_correct AS "relation_instances.is_correct",
        mention.id AS "relation_mentions.id",
        mention.is_correct AS "relation_mentions.is_correct",
        subj_link.id AS "el_candidate_link_2.subj.id",
        subj_link.is_correct AS "el_candidate_link_2.subj.is_correct",
        obj_link.id AS "el_candidate_link_2.obj.id",
        obj_link.is_correct AS "el_candidate_link_2.obj.is_correct"
    FROM relation_instances instance,
         relation_mentions mention,
         el_candidate_link_2 subj_link,
         el_candidate_link_2 obj_link
    WHERE subj_link.doc_id = obj_link.doc_id AND
          mention.doc_id = subj_link.doc_id AND
          subj_link.entity_id  = instance.subject_id AND
          subj_link.mention_id = mention.mid1  AND
          obj_link.entity_id   = instance.object_id  AND
          obj_link.mention_id  = mention.mid2   AND
          mention.rel = instance.rel AND
          obj_link.entity_id <> 'NIL0000' AND
          subj_link.entity_id <> 'NIL0000';
    """
  function: "Imply(relation_mentions.is_correct, el_candidate_link_2.subj.is_correct, el_candidate_link_2.obj.is_correct, relation_instances.is_correct)"
  weight: "?"
}
````

For each row of the input we are adding a factor that essentially is saying that given that the relation mention is correct and there exist valid candidate entities for both mentions in the mention-level relation, it is implied that the entity-level relation is correct.