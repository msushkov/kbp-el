#! /usr/bin/env python2.7

import fileinput
import string

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (mid, text) = row.strip().split('\t')

  feature = text.lower()

  print "\t".join([mid, feature])
