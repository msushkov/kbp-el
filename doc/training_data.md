---
layout: default
---

Adding training data
====

In order for the system to learn text patterns that indicate the presence of certain relationships between entities, we must provide training examples. We have an entity-level knowledge base of (entity1, relation, entity2) tuples (prodived in the database dump). Since our training data is entity-level but we need mention-level examples, we will use the distant supervision approach: for a given (entity1, relation, entity2) training example form the knowledge base, label all instances of (mention1, relation, mention2), where mention1 is a mention for the entity entity1 and mention2 is a mention for entity2, as being positive examples. To generate negative examples, use a list of incompatible relations.

Refer to http://www.stanford.edu/~jurafsky/mintz.pdf for a discussion on distant supervision.

# Positive examples

The positive examples come from the existing knowledge base table, `kb`. The table contains tuples of the form (entity1, relation, entity2). Note that our training data is entity-level; however, in order for the system to learn text patterns this data needs to be mapped to the mention level. Also note that since we are adding positive examples we insert True into the `is_correct` column of the `relation_mentions` table.

For each (entity1, relation, entity2) tuple in the knowledge base, the extractor finds mentions m1 and m2 that link to entities entity1 and entity2, respectively, and then joins the result with the relation mention feature table in order to extract the rellevant relation mention information. This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_positive {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT r.doc_id,
                      r.mid1,
                      r.mid2,
                      r.word1,
                      r.word2,
                      kb.rel,
                      True
      FROM relation_mention_features r,
           el_features_highprec t1,
           el_features_highprec t2,
           kb
      WHERE r.mid1 = t1.mention_id AND
            r.mid2 = t2.mention_id AND
            t1.fid = kb.eid1 AND
            t2.fid = kb.eid2 AND
            r.doc_id = t1.doc_id AND
            r.doc_id = t2.doc_id;
  """
  dependencies : ["ext_el_feature_coref", "ext_el_feature_extstr_title", 
                  "ext_el_feature_extstr_organization", "ext_el_feature_extstr_location",
                  "ext_el_feature_extstr_person", "ext_coref_candidate", "ext_coref_candidate",
                  "ext_relation_mention_feature", "ext_relation_mention_feature_deppath", 
                  "ext_mention", "ext_el_feature_alias_person",
                  "ext_el_feature_alias_title", "ext_el_feature_alias_location",
                  "ext_el_feature_alias_organization"]
  style: "sql_extractor"
}
```

**Query result:** mention-level positive training examples, e.g.:
    
                  doc_id              |                    mid1                    |                    mid2                    |          word1           |   word2   |    rel    | bool 
    ----------------------------------+--------------------------------------------+--------------------------------------------+--------------------------+-----------+-----------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614   | AFP_ENG_20020206.0348.LDC2007T07_590_599   | george w. bush           | president | per:title | t
     AFP_ENG_20050523.0367.LDC2007T07 | AFP_ENG_20050523.0367.LDC2007T07_1242_1267 | AFP_ENG_20050523.0367.LDC2007T07_1232_1241 | akbar hashemi rafsanjani | president | per:title | t
     AFP_ENG_20050523.0367.LDC2007T07 | AFP_ENG_20050523.0367.LDC2007T07_1389_1411 | AFP_ENG_20050523.0367.LDC2007T07_1232_1241 | ayatollah ali khamenei   | president | per:title | t

# Negative examples

Once we have constructed the positive examples, we can generate negative examples. The initial database contains a table called `incompatible_relations`: this table contains, for each of the relations r we want to extract, a relation that is incompatible with r. For example, for the relation `LOCATION_of_birth`, an incompatible relation would be `LOCATION_of_death`, since the same text patterns that would be indicative of the `LOCATION_of_birth` relation would not be indicative of the `LOCATION_of_death` relation.

More concretely, for a given positive training example

```(entity1, relation1, entity2),```

a negative example would be

```(entity1, relation2, entity2)```

where relation2 is incompatible with relation1. Note that since the table `relation_mentions` currently only contains the positive mention-level examples we generated in the above extractor, we can use that table directly to generate the negative examples by simply replacing the relations with incompatible relations. Also note that since we are adding negative examples we insert False into the `is_correct` column of the `relation_mentions` table.

This extractor is defined in `application.conf` using the following code:

```bash
ext_relation_mention_negative {
  sql: """
    INSERT INTO relation_mentions (doc_id, mid1, mid2, word1, word2, rel, is_correct)
      SELECT DISTINCT t0.doc_id,
                      t0.mid1,
                      t0.mid2,
                      t0.word1,
                      t0.word2,
                      t1.type2,
                      False
      FROM relation_mentions t0,
           incompatible_relations t1
      WHERE t0.rel = t1.type1 AND
            t0.is_correct = True AND
            t0.rel <> t1.type2;
  """
  dependencies : ["ext_relation_mention_positive"]
  style: "sql_extractor"
}
```

**Query result:** mention-level negative training examples, e.g.:

                  doc_id              |                   mid1                   |                   mid2                   |     word1      |   word2   |       type2        | bool 
    ----------------------------------+------------------------------------------+------------------------------------------+----------------+-----------+--------------------+------
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:age            | f
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:cause_of_death | f
     AFP_ENG_20020206.0348.LDC2007T07 | AFP_ENG_20020206.0348.LDC2007T07_600_614 | AFP_ENG_20020206.0348.LDC2007T07_590_599 | george w. bush | president | per:children       | f


We now need to generate the [mention-level relation candidates](relation_mentions.md).