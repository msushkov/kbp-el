--
-- This file defines database tables that are needed in addition to the ones provided in the
-- initial database dump.
--

--
-- FUNCTIONS
--

-- replacement for PSQL's buggy array_agg()
DROP AGGREGATE IF EXISTS array_accum(anyelement);
CREATE AGGREGATE array_accum(anyelement)
(
  sfunc = array_append,
  stype = anyarray,
  initcond = '{}'
);

-- Simple modification of the default array_to_string function that accepts a NULL symbol
-- (NULL values in the array will be replaced by this in the resulting string)
CREATE OR REPLACE FUNCTION my_array_to_string(dta anyarray, sep text, nullsym text) RETURNS text AS
$$
  SELECT array_to_string(ARRAY(SELECT coalesce(v::text, $3) FROM unnest($1) g(v)), $2)
$$ LANGUAGE sql;

--
-- TABLES
--

-- entity mentions
DROP TABLE IF EXISTS mentions CASCADE;
CREATE TABLE mentions (
	doc_id text,
	mention_id text,
	sentence_id text,
	word text,
	type text,
	start_pos int,
	end_pos int -- need to quote end, otherwise syntax error
);

-- relation mentions
DROP TABLE IF EXISTS relation_mentions CASCADE;
CREATE TABLE relation_mentions (
	doc_id text,
	id bigint,
	mid1 text,
	mid2 text,
	word1 text,
	word2 text,
	rel text,
	is_correct boolean
);

-- features for a given relation mention
-- (currently: word sequence, dependency path, presence of marriage keywords)
DROP TABLE IF EXISTS relation_mention_features CASCADE;
CREATE TABLE relation_mention_features (
	doc_id text,
	mid1 text,
	mid2 text,
	word1 text,
	word2 text,
	type1 text,
	type2 text,
	feature text
);


----
-- ENTITY MENTION FEATURES
----

-- text abbreviation (first letter of each word, but only if that letter is capitalized)
DROP TABLE IF EXISTS mention_feature_text_abbreviation CASCADE;
CREATE TABLE mention_feature_text_abbreviation (
  mid text,
  feature text
);

-- lowercase text
DROP TABLE IF EXISTS mention_feature_text_lc CASCADE;
CREATE TABLE mention_feature_text_lc (
  mid text,
  feature text
);

-- the alphanumeric text
DROP TABLE IF EXISTS mention_feature_text_alphanumeric CASCADE;
CREATE TABLE mention_feature_text_alphanumeric (
  mid text,
  feature text
);

-- the lowercase alphanumeric text
DROP TABLE IF EXISTS mention_feature_text_alphanumeric_lc CASCADE;
CREATE TABLE mention_feature_text_alphanumeric_lc (
  mid text,
  feature text
);

-- unigrams of the mention text
DROP TABLE IF EXISTS mention_feature_text_ngram1 CASCADE;
CREATE TABLE mention_feature_text_ngram1 (
  mid text,
  feature text
);

-- number of words in mention text
DROP TABLE IF EXISTS mention_feature_text_num_words CASCADE;
CREATE TABLE mention_feature_text_num_words (
  mid text,
  feature text
);

----
-- ENTITY LINKING
----

-- (entity, mention) pairs that could potentially be linked
DROP TABLE IF EXISTS el_candidate_link CASCADE;
CREATE TABLE el_candidate_link (
  eid text,
  mid text,
  is_correct boolean
);

DROP TABLE IF EXISTS el_candidate_link_2 CASCADE;
CREATE TABLE el_candidate_link_2 (
  eid text,
  mid text,
  is_correct boolean
);