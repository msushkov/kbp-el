---
layout: default
---

Debugging extractors
====

It is useful to debug each extractor individually without running the DeepDive system every time. To make this easier, a general debug extractor is provided in `udf/util/dummy_extractor.py`. This extractor produces a file from the SQL input query to allow the user to directly pipe that file into the desired extractor. Run the dummy extractor once to produce the sample file, and then debug the extractor by looking at the output without running the DeepDive pipeline.

For example, consider a scenario where we want to debug the entity mention extractor, `ext_mention`. We can first run `ext_mention_debug` to produce a sample TSV file, `udf/sample_data/ext_mention_sample_data.tsv`.

Refer to [DeepDive's pipeline functionality](http://deepdive.stanford.edu/doc/pipelines.html) to see how to run the system with only a particular extractor. We can specify something like the following in `application.conf`:

    pipeline.run: "debug_mention_ext"
    pipeline.pipelines.debug_mention_ext: ["ext_mention_debug"]

After running run.sh, this file can then be piped into the extractor we wish to debug, `udf/ext_mention.py`:

    >> cat $APP_HOME/udf/sample_data/ext_mention_sample_data.tsv | python $APP_HOME/udf/ext_mention.py

This process allows for interactive debugging of the extractors.

Note that if you change the inut SQL query to an extractor, you will also need to change it in the debug version of that extractor.

The code for `ext_mention_debug` is commented out in `application.conf`; similar code is also provided for `ext_relation_mention_feature_wordseq`, `ext_relation_mention_feature_deppath`, and `mention_text_num_words`.

Now that we have our extractors, let's see how we can [write the inference rules](inference_rules.md).