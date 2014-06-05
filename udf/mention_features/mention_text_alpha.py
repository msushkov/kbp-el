#! /usr/bin/env python2.7

import fileinput
import string

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (mid, text) = row.strip().split('\t')

  # get the alphanumeric chars
  an = [c for c in text if c.isalnum()]
  feature = "".join(an)

  print "\t".join([mid, feature])
