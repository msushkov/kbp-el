---
layout: default
---

Generating relation mentions
====

As the final extractor, we generate the non-example relation mentions that we want to run inference on. Each of these relation mentions will have NULL in the `is_correct` column, meaning that DeepDive will treat it as a random variable and will perform inference on its value. Since we have already generated the `relation_mention_features` table, we can simply use that, along with the `relation_types` table, to get the appropriately-typed relation mentions.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT t1.doc_id,
                      t1.mid1,
                      t1.mid2,
                      t1.word1,
                      t1.word2,
                      t0.rel,
                      NULL::boolean
      FROM relation_types t0,
           relation_mention_features t1
      WHERE t0.type1 = t1.type1 AND
            t0.type2 = t1.type2;
  """
  dependencies : ["ext_relation_mention_positive", "ext_relation_mention_negative"]
  style: "sql_extractor"
}
```

**Query result:** non-training relation mentions, e.g.:

                  doc_id              |                    mid1                    |                    mid2                    |  word1  |   word2    |              rel             | bool 
    ----------------------------------+--------------------------------------------+--------------------------------------------+---------+------------+------------------------------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1015_1025 | defense | washington | org:LOCATION_of_headquarters | 
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1065_1072 | defense | tuesday    | org:founded                  | 
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_1186_1193 | AFP_ENG_20020206.0348.LDC2007T07_1135_1139 | defense | iran       | org:LOCATION_of_headquarters |
