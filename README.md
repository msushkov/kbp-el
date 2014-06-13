---
layout: default
---

Knowledge Base Population (KBP)
====

In this document we will build an application for [the slot filling task](http://surdeanu.info/kbp2014/KBP2014_TaskDefinition_EnglishSlotFilling_1.1.pdf) of the 
[TAC KBP competition](http://www.nist.gov/tac/2014/KBP/). Slot filling involves extracting information about entities in text; the goal is to use a seed knowledge base to create an augmented knowledge base of *(entity, relation, entity)* tuples (the second entity is referred to as the "slot").[The relationships are defined by the competition guidelines](http://surdeanu.info/kbp2014/TAC_KBP_2014_Slot_Descriptions.pdf).

This example uses a sample of the data for the 2010 task. Note that the data provided in this example application is only 0.2% of the original corpus so the recall (and thus the F1 score) will be low. However, using 100% of the 2010 corpus, this example system achieves an F1 score of XX on the KBP task, which [beats the top result of 29](http://nlp.cs.rpi.edu/paper/kbp2010overview.pdf) from the 2010 competition.

Note that in order to run the system on the full data set, you need to replace 2 tables with their full versions (but with the same exact schema): `sentence` and `freebase`.

## Application overview

The application is an extension of the [mention-level extraction system](http://deepdive.stanford.edu/doc/walkthrough-mention.html), so please make sure you have gone through that part of the tutorial and have an understanding of basic relation extraction using DeepDive. The main difference here is that we are now concerned with **entity-level relationships**, not mention-level. In other words,

given the following input:

- a set of sentences with NLP features
- a set of Freebase entities
- an entity-level training set of the form *(entity1, relation, entity2)*,

instead of producing a set of *(mention1, relation, mention2)* tuples as the final output, we want to produces tuples of the form *(entity1, relation, entity2)*.

Note that in order to obtain the entity-level result we need to perform **entity linking**, which will associate mentions in text with Freebase entities (the mentions "Barack Hussein Obama" and "President Barack Obama" all refer to the entity **Barack Obama**). 

This tutorial will walk you through building a full DeepDive application that extracts relationships between entities in raw text. We use **news articles and blogs** as our input data and want to **extract all pairs of entities** that participate in the KBP relations (e.g. *Barack Obama* and *Michelle Obama* for the `spouse` relation).

The application performs the following high-level steps:

1. Load data from provided database dump
2. Extract features. This includes steps to:
  - Extract entity mentions from sentences
  - Extract lexical and syntactic features from mention-level relation candidates (entity mention pairs in the same sentence)
  - Link Freebase entities to mentions in text (entity linking)
  - Generate positive and negative training examples for relation candidates
  - Extract the non-example mention-level relation candidates
  - Extract the entity-level relation candidates by combining the mention-level candidates with entity linking
3. Generate a factor graph using inference rules
4. Perform inference and learning
5. Generate results

Let us now go through the steps to get the example KBP system up and running.

### Contents

* [Installing DeepDive](#installing-deepdive)
* [Setting up KBP application](doc/setting_up.md)
* [Running KBP application](doc/running.md)
* [Evaluating the results](doc/evaluating.md)
* [Writing extractors](doc/writing_extractors.md)
* [Debugging extractors](doc/debugging_extractors.md)
* [Writing inference rules](doc/inference_rules.md)

## Installing DeepDive

This tutorial assumes a working installation of DeepDive.
Please go through the
[example application walkthrough](http://deepdive.stanford.edu/doc/walkthrough.html) before proceeding.

After following the walkthrough, your `deepdive` directory should contain a folder called `app`, which should contain a folder called `spouse`.

Let's now proceed to a tutorial for [setting up the KBP application](doc/setting_up.md), which will help you get started.
