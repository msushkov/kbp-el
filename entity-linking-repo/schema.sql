
----
-- MENTION FEATURES
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
-- CANDIDATE LINKS
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

----
-- ENTITY LINKING FEATURES
----


-- ROUND 1


-- Rule 1: Everything is NIL by default
DROP TABLE IF EXISTS el_everything_nil CASCADE;
CREATE TABLE el_everything_nil (
  eid text,
  mid text
);

-- Rule 2: exact string matching
DROP TABLE IF EXISTS el_exact_str_match CASCADE;
CREATE TABLE el_exact_str_match (
  eid text,
  mid text
);

-- Rule 3: Wiki link
DROP TABLE IF EXISTS el_wiki_link CASCADE;
CREATE TABLE el_wiki_link (
  eid text,
  mid text
);

-- Rule 4: Wiki redirect
DROP TABLE IF EXISTS el_wiki_redirect CASCADE;
CREATE TABLE el_wiki_redirect (
  eid text,
  mid text
);

-- Rule 5: top Bing result
DROP TABLE IF EXISTS el_top_bing_result CASCADE;
CREATE TABLE el_top_bing_result (
  eid text,
  mid text
);

-- Rule 6: Bing result
DROP TABLE IF EXISTS el_bing_result CASCADE;
CREATE TABLE el_bing_result (
  eid text,
  mid text
);


-- ROUND 2

-- Rule 9: promote entity-mention links with consistent types
DROP TABLE IF EXISTS el_consistent_types CASCADE;
CREATE TABLE el_consistent_types (
  eid text,
  mid text
);

-- Rule 10: Break ties using the more popular entity, but only if the other
-- entity is the most popular (80 means most popular)
DROP TABLE IF EXISTS el_entity_popularity CASCADE;
CREATE TABLE el_entity_popularity (
  eid text,
  mid text
);

-- Rule 11: never believe that a single first/last name can provide useful info
DROP TABLE IF EXISTS el_dont_trust_single_name CASCADE;
CREATE TABLE el_dont_trust_single_name (
  eid text,
  mid text
);

-- Rule 12: Context rule. Intuitively, if Wisconsin co-occurs with Madison, then promote
-- the entity ''Madison, WI''
DROP TABLE IF EXISTS el_context CASCADE;
CREATE TABLE el_context (
  eid text,
  mid text
);

-- Rule 13: Location words are ambiguous (city/town)
DROP TABLE IF EXISTS el_city_town_ambiguous CASCADE;
CREATE TABLE el_city_town_ambiguous (
  eid text,
  mid text
);

-- Rule 14: Location words are ambiguous (state)
DROP TABLE IF EXISTS el_state_ambiguous CASCADE;
CREATE TABLE el_state_ambiguous (
  eid text,
  mid text
);

-- Rule 15: Impossible to involve an /internet/social_network_user in TAC KBP
DROP TABLE IF EXISTS el_no_social_network_user CASCADE;
CREATE TABLE el_no_social_network_user (
  eid text,
  mid text
);

-- Rule 16: Impossible to involve a /time/event in TAC KBP
DROP TABLE IF EXISTS el_no_time_event CASCADE;
CREATE TABLE el_no_time_event (
  eid text,
  mid text
);

-- Rule 17: Impossible to involve a /people/family_name in TAC KBP
DROP TABLE IF EXISTS el_no_family_name CASCADE;
CREATE TABLE el_no_family_name (
  eid text,
  mid text
);

-- Rule 18: Impossible to involve a /base/givennames/given_name in TAC KBP
DROP TABLE IF EXISTS el_no_given_name CASCADE;
CREATE TABLE el_no_given_name (
  eid text,
  mid text
);

-- Rule 19: Impossible to involve a /base/wfilmbase/film in TAC KBP
DROP TABLE IF EXISTS el_no_film CASCADE;
CREATE TABLE el_no_film (
  eid text,
  mid text
);


