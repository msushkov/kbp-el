#! /bin/bash

psql $DBNAME -c "DROP TABLE IF EXISTS result;"
psql $DBNAME -c "DROP TABLE IF EXISTS best_result;"

psql $DBNAME """
	ANALYZE el_candidate_link;
"""

psql $DBNAME """
	ANALYZE el_candidate_link_2;
"""

psql $DBNAME """
	ANALYZE entities;
"""

psql $DBNAME """
	ANALYZE mentions;
"""

psql $DBNAME """
	ANALYZE el_kbp_eval_query;
"""


psql $DBNAME -c """
	CREATE TABLE result AS (
		SELECT eval_query.query_id AS query_id,
		       e.fid AS freebase_id,
		       link.expectation AS probability
	    FROM el_candidate_link_2_is_correct_inference AS link,
	         entities AS e,
	         mentions AS m,
	         el_kbp_eval_query AS eval_query
	    WHERE link.entity_id = e.fid AND
	          link.mention_id = m.mention_id AND
	          eval_query.doc_id = m.doc_id AND
	          eval_query.text = m.word
);"""

psql $DBNAME -c """
	CREATE TABLE best_result AS (
		SELECT query_id, MAX(probability) AS probability
		FROM result
		GROUP BY query_id
);"""


rm $EL_RESULTS_FILE
touch $EL_RESULTS_FILE

psql $DBNAME -c """\COPY (
		SELECT DISTINCT ON (el_kbp_eval_query.query_id) el_kbp_eval_query.query_id,
		       CASE WHEN eid_to_fid.entity_id IS NOT NULL THEN eid_to_fid.entity_id
		            ELSE 'NIL'
		       END
		FROM el_kbp_eval_query LEFT JOIN best_result ON
			best_result.query_id = el_kbp_eval_query.query_id
	      LEFT JOIN result ON
	        result.query_id = best_result.query_id AND result.probability = best_result.probability
	      LEFT JOIN eid_to_fid ON
	         eid_to_fid.freebase_id = result.freebase_id
	) TO '$EL_RESULTS_FILE' WITH DELIMITER AS E'\t'
;"""

psql $DBNAME -c "DROP TABLE IF EXISTS result;"
psql $DBNAME -c "DROP TABLE IF EXISTS best_result;"


perl $APP_HOME/evaluation/entity-linking/kbpenteval.pl $APP_HOME/evaluation/entity-linking/el_2010_eval_answers.tsv $APP_HOME/evaluation/entity-linking/results/out.tsv
