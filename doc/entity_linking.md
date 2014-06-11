---
layout: default
---

Entity linking
====

To identify which mentions in text refer to which entities, we need to perform entity linking. This involves extracting specific features from *(entity, mention)* pairs. 

# Exact string match between entities and mentions

This extractor extracts the "exact string match" feature between (entity, mention) pairs (this feature is denoted as 'es'). An (entity, mention) pair emits the 'es' feature if the following conditions hold:
- the entity and mention have corresponding types
- the entity and mention strings match exactly.

In the case of the *PERSON* entities and mentions, we have an additonal condition:
- the mention string contains a space.

There are several *exact-string-match* extractors for different types of entities and mentions:
- `ext_el_feature_extstr_person` considers mentions of the *PERSON* type and entities of the *people.person* type
- `ext_el_feature_extstr_location` considers mentions of the *LOCATION* type and entities of the *location.location* type
- `ext_el_feature_extstr_organization` considers mentions of the *ORGANIZATION* type and entities of the *organization.organization* type
- `ext_el_feature_extstr_title` considers mentions of the *TITLE* type and entities of the *business.job_title* type
- `ext_el_feature_extstr_title2` considers mentions of the *TITLE* type and entities of the *government.government_office_or_title* type

Each of these extractors is defined in `application.conf` using code nearly identical to the following, with some potential differences in the WHERE condition depending on the types. This example is for entities and mentions of the *LOCATION* type:

```bash
ext_el_feature_extstr_location {
  sql: """
    INSERT INTO el_features_highprec
      SELECT m.doc_id,
             m.mention_id,
             e.fid,
             'es'::TEXT AS feature
      FROM   mentions m,
             entities e
      WHERE  m.type = 'LOCATION' AND
             e.type = 'location.location' AND
             m.word = e.text;
  """
  dependencies : ["ext_el_feature_extstr_person"]
  style: "sql_extractor"
}
```

**Query result:** (entity, mention) pairs of the *LOCATION* type whose text matches exactly, e.g.:

                  doc_id              |                 mention_id                 |    fid    | feature 
    ----------------------------------+--------------------------------------------+-----------+---------
     NYT_ENG_20071001.0094.LDC2009T13 | NYT_ENG_20071001.0094.LDC2009T13_9731_9738 | m.0496l40 | es
     NYT_ENG_20070518.0055.LDC2009T13 | NYT_ENG_20070518.0055.LDC2009T13_8917_8924 | m.0496l40 | es
     APW_ENG_20081023.0044.LDC2009T13 | APW_ENG_20081023.0044.LDC2009T13_3225_3231 | m.0489wbm | es

Let's show the results with the mention and entity text for clarity:

                  doc_id              |                 mention_id                 |  word   |    fid    | entity_text | feature 
    ----------------------------------+--------------------------------------------+---------+-----------+-------------+---------
     NYT_ENG_20070514.0225.LDC2009T13 | NYT_ENG_20070514.0225.LDC2009T13_3328_3335 | milford | m.0206xw3 | milford     | es
     APW_ENG_20070317.0852.LDC2009T13 | APW_ENG_20070317.0852.LDC2009T13_857_864   | milford | m.0206xw3 | milford     | es
     APW_ENG_20070317.0852.LDC2009T13 | APW_ENG_20070317.0852.LDC2009T13_269_276   | milford | m.0206xw3 | milford     | es

All of these are SQL extractors, which means that they have no UDF but simply execute a query.

# Exact string match between Freebase aliases for entities and mentions

In addition to exact string match between entities and mention, we consider in the entity linking step (entity, mention) pairs where the entity has a Freebase alias whose text is an exact match for the mention text. The extractors are similar to the exact string match above, but each input query now also performs a join on the `fbalias` table. The extractors extract the "alias" feature between (entity, mention) pairs (this feature is denoted as 'al'). An (entity, mention) pair emits the 'al' feature if the following conditions hold:
- the entity and mention have corresponding types
- the entity has a Freebase alias
- the entity's alias and mention text match exactly.

In the case of the *PERSON* entities and mentions, we have an additonal condition:
- the mention string contains a space.

There are several *alias* extractors for different types of entities and mentions:
- `ext_el_feature_alias_person` considers mentions of the *PERSON* type and entities of the *people.person* type
- `ext_el_feature_alias_location` considers mentions of the *LOCATION* type and entities of the *location.location* type
- `ext_el_feature_alias_organization` considers mentions of the *ORGANIZATION* type and entities of the *organization.organization* type
- `ext_el_feature_alias_title` considers mentions of the *TITLE* type and entities of the *business.job_title* type

Each of these extractors is defined in `application.conf` using code nearly identical to the following, with some potential differences in the WHERE condition depending on the types. This example is for entities and mentions of the *LOCATION* type:

```bash
ext_el_feature_alias_location {
  sql: """
    INSERT INTO el_features_highprec
      SELECT m.doc_id,
             m.mention_id,
             e.fid,
             'al'::TEXT AS feature
      FROM   mentions m,
             entities e,
             fbalias f
      WHERE  m.type = 'LOCATION' AND
             e.type = 'location.location' AND
             m.word = f.slot AND
             e.fid = f.fid;
  """
  dependencies : ["ext_el_feature_extstr_person"]
  style: "sql_extractor"
}
```

**Query result:** (entity, mention) pairs of the *LOCATION* type such that the entity has a Freebase alias whose text matches exactly the text of the mention, e.g.:
    
                  doc_id              |                mention_id                |    fid    | feature 
    ----------------------------------+------------------------------------------+-----------+---------
     eng-WL-11-174587-12962117        | eng-WL-11-174587-12962117_805_813        | m.0ldgnrl | al
     eng-WL-11-174595-12968511        | eng-WL-11-174595-12968511_11478_11486    | m.04drmh  | al
     APW_ENG_20080907.0722.LDC2009T13 | APW_ENG_20080907.0722.LDC2009T13_619_627 | m.04drmh  | al

Let's show the results with the mention and entity text for clarity:

                 doc_id               |               mention_id                 |   word   |     fid      | alias_text | feature 
    ----------------------------------+------------------------------------------+----------+--------------+------------+---------
        eng-WL-11-174587-12962117     |   eng-WL-11-174587-12962117_805_813      | the bank |  m.0ldgnrl   | the bank   | al
        eng-WL-11-174595-12968511     |   eng-WL-11-174595-12968511_11478_11486  | montreal |  m.04drmh    | montreal   | al
     APW_ENG_20080907.0722.LDC2009T13 | APW_ENG_20080907.0722.LDC2009T13_619_627 | montreal |  m.04drmh    | montreal   | al



All of these are SQL extractors, which means that they have no UDF but simply execute a query.

