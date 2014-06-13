---
layout: default
---

Writing extractors
====

In order to extract the necessary features from text and set up the tables for DeepDive's learning and inference steps, we must add extractors. The extractors are created in `application.conf`. Several extractors in this example are [TSV extractors](http://deepdive.stanford.edu/doc/extractors.html#tsv_extractor) and some are [command-line extractors](http://deepdive.stanford.edu/doc/extractors.html#cmd_extractor), and the UDFs for them are contained in `APP_HOME/udf`. However, the majority are [SQL extractors](http://deepdive.stanford.edu/doc/extractors.html#sql_extractor) that do not have UDFs.

As stated in the [overview](../README.md), the extractors perform the following high-level tasks:

- [Extract entity mentions from sentences](entity_mentions.md)
- [Extract lexical and syntactic features for relation mentions (entity mentions pairs in the same sentence)](relation_mention_features.md)
- [Extract candidates for entity linking based on several features (linking Freebase entities to mentions in text).](entity_linking.md) These features include:
  - Exact string match
  - Freebase alias
  - Consistent types
  etc.
- [Add positive and negative training examples for relation mentions](training_data.md)
- [Extract mention-level relation candidates](relation_mentions.md)
- [Extract entity-level relation candidates](relation_instances.md)

Note that the entity linking step is necessary because our training data is at the entity level, but in order for the system to learn text patterns, this needs to be mapped to the mention level. That entity -> mention mapping is the entity linking.

We will now walk through each of the extractors in more detail.

# Cleanup

The first extractor that needs to run is `ext_cleanup`. This extractor cleans up the tables that will be populated by the extractors. This extractor is defined in `application.conf` using the following code:

```bash
ext_cleanup {
  sql: """
    DELETE FROM relation_mentions;
    DELETE FROM relation_mention_features;
    DELETE FROM mentions;
    DELETE FROM mention_feature_text_num_words;
  """
  style: "sql_extractor"
}
```

The first step is to [extract entity mentions](entity_mentions.md) from raw text.
