#! /usr/bin/env python

"""
Extractor for entity mentions.

A mention can consist of multiple words (e.g. Barack Obama); the way we can identify these is 
if all of these words have the same NER tag.

This extractor goes through all the words in the sentence and outputs as a mention the consecutive
words that have the same NER tag that is not in EXT_MENTION_IGNORE_TYPE.

Input query:

                SELECT doc_id,
                             sentence_id,
                             my_array_to_string(words, '~^~', 'NULL') AS words,
                             my_array_to_string(ner, '~^~', 'NULL') AS ner,
                             my_array_to_string(character_offset_begin, '~^~', 'NULL') AS character_offset_begin,
                             my_array_to_string(character_offset_end, '~^~', 'NULL') AS character_offset_end
                FROM sentence
"""

import sys

# the NER tags that wil not correspond to entity mentions types
EXT_MENTION_IGNORE_TYPE = {'URL': 1, 'NUMBER' : 1, 'MISC' : 1, 'CAUSE_OF_DEATH' : 1,
        'CRIMINAL_CHARGE' : 1, 'DURATION' : 1, 'MONEY' : 1, 'ORDINAL' : 1, 'RELIGION' : 1,
        'SET' : 1, 'TIME' : 1}

# words that are representative of the TITLE type
EXT_MENTION_TITLE_TYPE = {'winger' : 1, 'singer\\\\/songwriter' : 1, 'founder' : 1,
        'president' : 1, 'executive director' : 1, 'producer' : 1, 'star' : 1, 'musician' : 1,
        'nightlife impresario' : 1, 'lobbyist' : 1}

# the delimiter used to separate columns in the input
ARR_DELIM = '~^~'

for row in sys.stdin:
    # row is a string where the columns are separated by tabs
    (doc_id, sentence_id, words_str, ner_str, character_offset_begin_str, \
        character_offset_end_str) = row.strip().split('\t')

    words = words_str.split(ARR_DELIM)
    ner = ner_str.split(ARR_DELIM)
    character_offset_begin = map(lambda x: int(x), character_offset_begin_str.split(ARR_DELIM))
    character_offset_end = map(lambda x: int(x), character_offset_end_str.split(ARR_DELIM))

    # keep track of words whose NER tags we look at
    history = {}

    # go through each word in the sentence
    for i in range(0, len(words)):
        # if we already looked at this word's NER tag, skip it
        if i in history:
            continue

        # the NER tag for the current word
        curr_ner = ner[i]

        # skip this word if this NER tag should be ignored
        if curr_ner in EXT_MENTION_IGNORE_TYPE:
            continue

        # collapse specific location types
        if curr_ner in ["CITY", "COUNTRY", "STATE_OR_PROVINCE"]:
            curr_ner = "LOCATION"

        # if the current word has a valid NER tag
        if curr_ner != 'O' and curr_ner != 'NULL':
            j = i

            # go through each of the words after the current word until the end of the sentence
            for j in range(i, len(words)):
                nerj = ner[j]

                # collapse specific location types
                if nerj in ["CITY", "COUNTRY", "STATE_OR_PROVINCE"]:
                    nerj = "LOCATION"

                # go until the NER tags of word 1 and word 2 do not match
                if nerj != curr_ner:
                    break

            # at this point we have a mention that consists of consecutive words with the same NER 
            # tag (or just a single word if the next word's NER tag is different)

            # construct a unique ID for this entity mention
            mention_id = doc_id + "_%d_%d" % (character_offset_begin[i], character_offset_end[j-1])

            # if our mention is just a single word, we want just that word
            if i == j:
                j = i + 1
                word = words[i]
                history[i] = 1

            # if our mention is multiple words, combine them and mark that we have already seen them
            else:
                word = " ".join(words[i:j])
                for w in range(i,j):
                    history[w] = 1

            # doc_id, mention_id, sentence_id, word, type, start_pos, end_pos
            output = [doc_id, mention_id, sentence_id, word.lower(), curr_ner, str(i), str(j)]

            # make sure each of the strings we will output is encoded as utf-8
            map(lambda x: x.decode('utf-8', 'ignore'), output)

            print "\t".join(output)
        
        # if this word has an NER tag of '0' or NULL
        else:
            # if the current word is one of the known titles, then we have a TITLE mention
            if words[i].lower() in EXT_MENTION_TITLE_TYPE:
                history[i] = 1
                word = words[i]
                
                # construct a unique ID for this entity mention
                mention_id = doc_id + "_%d_%d" % (character_offset_begin[i], character_offset_end[i])
                
                # doc_id, mention_id, sentence_id, word, type, start_pos, end_pos
                output = [doc_id, mention_id, str(sentence_id), word.lower(), 'TITLE', str(i), str(i + 1)]

                # make sure each of the strings we will output is encoded as utf-8
                map(lambda x: x.decode('utf-8', 'ignore'), output)

                print "\t".join(output)
            
