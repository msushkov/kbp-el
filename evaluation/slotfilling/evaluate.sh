#! /usr/bin/env bash

# Error checks
set -e
if [ "$1" = "" ]; then
  echo "Usage: `basename $0` <year>"
  exit 1
fi
export KBPYEAR="KBP$1"

# Set up some environment variables
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURDIR=`pwd`
CLASSPATH=$DIR/javanlp.jar:$DIR/typesafe-config.jar:$DIR/kryo.jar:$DIR/lucene-core.jar:$DIR/lucene-analyzers.jar:$DIR/postgresql.jar 

# Compile DeepDiveSlotFiller
cd $DIR
javac -cp $CLASSPATH edu/stanford/nlp/kbp/slotfilling/evaluate/DeepDiveSlotFiller.java
CLASSPATH=.:$CLASSPATH

# Run the evaluation
java -cp $CLASSPATH edu.stanford.nlp.kbp.slotfilling.SlotfillingSystem $DIR/deepdive.conf
cd $CURDIR
