#! /bin/bash

export APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DEEPDIVE_HOME="$( cd $APP_HOME && cd ../..  && pwd )"

# Machine Configuration
export MEMORY="64g"
export PARALLELISM=8

# SBT Options
export SBT_OPTS="-Xmx$MEMORY"

# Database Configuration (default)
export DBNAME="deepdive_deepdive_mikhail"
export PGUSER=${PGUSER:-`whoami`}
export PGPASSWORD=${PGPASSWORD:-}
export PGPORT=${PGPORT:-5432}
export PGHOST=${PGHOST:-localhost}

# the deepdive_kbp DB dump files (2 of them to fit Github's size limit)
export DB_DUMP_FILE_1=$APP_HOME/data/deepdive_kbp.sql.tar.bz2.1
export DB_DUMP_FILE_2=$APP_HOME/data/deepdive_kbp.sql.tar.bz2.2

# the combined DB dump file that will be used to recreate the DB
export DB_DUMP_FILE_COMBINED=$APP_HOME/data/deepdive_kbp.sql.tar.bz2
export DB_DUMP_FILE_UNCOMPRESSED=$APP_HOME/data/deepdive_kbp.sql

# tables used in the entity linking step
export ENTITY_LINKING_TABLES=$APP_HOME/data/entity_linking_tables.tar.gz
export ENTITY_LINKING_TABLES_DIR=$APP_HOME/data/entity_linking_tables
