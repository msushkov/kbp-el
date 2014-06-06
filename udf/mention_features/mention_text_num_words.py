#! /usr/bin/env python

import sys

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (doc_id, mid, text) = row.strip().split('\t')

  # get the number of words
  feature = str(len(text.strip().split()))

  print "\t".join([doc_id, mid, feature])
