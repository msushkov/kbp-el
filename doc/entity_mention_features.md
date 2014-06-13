---
layout: default
---

Extracting features from entity mentions
====

We need to extract features from the entity mentions we have just extracted so that these can be used in entity linking. In this example, we extract a single feature for entity mentions: the number of words.

This extractor is defined in `application.conf` using the following code:

```bash
mention_text_num_words {
	input: """
	  SELECT doc_id,
	         mention_id,
	         word
	    FROM mentions
	"""
	output_relation: "mention_feature_text_num_words"
	udf: ${APP_HOME}"/udf/mention_features/mention_text_num_words.py"
	style: "tsv_extractor"
	dependencies: ["ext_mention"]
}
```

**Input:** an entity mention. Specically, each line in the input to this extractor UDF is a row of the input query in TSV format, e.g.:

	AFP_ENG_20070405.0102.LDC2009T13	AFP_ENG_20070405.0102.LDC2009T13_497_505	larijani
	AFP_ENG_20070405.0102.LDC2009T13	AFP_ENG_20070405.0102.LDC2009T13_515_519	iran
	AFP_ENG_20070405.0102.LDC2009T13	AFP_ENG_20070405.0102.LDC2009T13_522_555	supreme national security council

**Output:** rows in `mention_feature_text_num_words` table, e.g.:

	              doc_id              |                   mid                    | feature 
	----------------------------------+------------------------------------------+---------
	 AFP_ENG_20070405.0102.LDC2009T13 | AFP_ENG_20070405.0102.LDC2009T13_497_505 | 1
	 AFP_ENG_20070405.0102.LDC2009T13 | AFP_ENG_20070405.0102.LDC2009T13_515_519 | 1
	 AFP_ENG_20070405.0102.LDC2009T13 | AFP_ENG_20070405.0102.LDC2009T13_522_555 | 4

The script `$APP_HOME/udf/ext_relation_mention_features_wordseq.py` is the UDF for this extractor:

```python
#! /usr/bin/env python

import sys

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (doc_id, mid, text) = row.strip().split('\t')

  # get the number of words
  feature = str(len(text.strip().split()))

  print "\t".join([doc_id, mid, feature])
```


Next, we need to perform [entity linking](entity_linking.md).