#! /bin/bash

export APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DEEPDIVE_HOME="$( cd $APP_HOME && cd ../..  && pwd )"

source "$APP_HOME/env.sh"
source "$APP_HOME/env_db.sh"

echo "Dropping the database..."
date
dropdb $DBNAME

echo "Creating the database..."
date
createdb $DBNAME

# combine the dump files together
echo "Combining DB dump files..."
date
cat $DB_DUMP_FILE_1 $DB_DUMP_FILE_2 > $DB_DUMP_FILE_COMBINED
cd $APP_HOME/data
tar xf $DB_DUMP_FILE_COMBINED
cd $APP_HOME

# restore the database from the dump
echo "Restoring DB from dump..."
date
psql $DBNAME < $DB_DUMP_FILE_UNCOMPRESSED

# additional tables
psql $DBNAME < schema.sql

# ground truth for error analysis
psql $DBNAME < $APP_HOME/data/ea.sql


cd $APP_HOME/data

# if we haven't already extracted entity_linking_tables.tar.gz, extract it
if [ ! -d "$ENTITY_LINKING_TABLES_DIR" ]; then
  tar -xzf $ENTITY_LINKING_TABLES
fi

# load the entity linking tables into the DB
for file in `find $ENTITY_LINKING_TABLES_DIR -name "*.sql"`; do 
  psql $DBNAME < $file
done

# insert NIL entity into entities table (need this for entity linking)
psql $DBNAME -c """
	INSERT INTO entities VALUES ('NIL0000', 'NIL0000', 'NIL0000');
"""

# load Freebase into the DB
bunzip2 $FREEBASE_ZIPPED
psql $DBNAME < $FREEBASE

cd $APP_HOME

