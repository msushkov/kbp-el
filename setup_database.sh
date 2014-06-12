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
cat $DB_DUMP_FILE_1 $DB_DUMP_FILE_2 $DB_DUMP_FILE_3 $DB_DUMP_FILE_4 > $DB_DUMP_FILE_COMBINED
cd $APP_HOME/data
bunzip2 $DB_DUMP_FILE_COMBINED
cd $APP_HOME

# restore the database from the dump
echo "Restoring DB from dump..."
date
psql -d $DBNAME -f $DB_DUMP_FILE_UNCOMPRESSED

cd $APP_HOME