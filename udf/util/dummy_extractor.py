#! /usr/bin/env python

import sys

"""
Dummy extractor to simply spit out the input query as a file.
This is useful for debugging extractors.

The filename must be passed as the only argument to this script.
"""

f = open(sys.argv[1], 'a')
for row in sys.stdin:
	f.write(row)
f.close()