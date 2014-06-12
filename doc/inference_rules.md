---
layout: default
---

Writing inference rules
====

TODO: finish

Now we need to tell DeepDive how to generate a factor graph to perform probabilistic inference. We want ultimately to predict the `is_correct` column of the `relation_instances` table, but this output variables relies on the system's predictions for `is_correct` columsn of the entity linking tables, as well as the `is_correct` column of the `relation_mentions` table.

# Entity linking

TODO

# Relation mentions

First, we want to predict the value of the `is_correct` column of the `relation_mentions` table based on the features we have extracted, by assigning each feature a weight that DeepDive will learn.

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

TODO
