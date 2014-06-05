#! /usr/bin/env python2.7

import fileinput
import json

for line in fileinput.input():
	row = json.loads(line.decode("latin-1").encode("utf-8"))
	
	mid = row['mention.id']
	text = row['mention.text']

	print json.dumps({
		"mention_id" : int(mid),
		"value" : str(len(text.strip().split()))
	})


#! /usr/bin/env python2.7

import fileinput
import string

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
  # row is a string where the columns are separated by tabs
  (mid, text) = row.strip().split('\t')

  # get the number of words
  feature = str(len(text.strip().split()))

  print "\t".join([mid, feature])
