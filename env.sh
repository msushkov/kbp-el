#! /bin/bash

export APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DEEPDIVE_HOME="$( cd $APP_HOME && cd ../..  && pwd )"

# Machine Configuration
export MEMORY="64g"
export PARALLELISM=8

# SBT Options
export SBT_OPTS="-Xmx$MEMORY"

# Database Configuration (default)
export DBNAME="deepdive_kbp"
export PGUSER=${PGUSER:-`whoami`}
export PGPASSWORD=${PGPASSWORD:-}
export PGPORT=${PGPORT:-5432}
export PGHOST=${PGHOST:-localhost}

# the deepdive_kbp DB dump files (2 of them to fit Github's size limit)
export DB_DUMP_FILE_1=$APP_HOME/data/db_dump/deepdive_kbp.sql.1.bz2
export DB_DUMP_FILE_2=$APP_HOME/data/db_dump/deepdive_kbp.sql.2.bz2
export DB_DUMP_FILE_3=$APP_HOME/data/db_dump/deepdive_kbp.sql.3.bz2
export DB_DUMP_FILE_4=$APP_HOME/data/db_dump/deepdive_kbp.sql.4.bz2

# the combined DB dump file that will be used to recreate the DB
export DB_DUMP_FILE_UNCOMPRESSED=$APP_HOME/data/deepdive_kbp.sql
export DB_DUMP_FILE_COMBINED=$DB_DUMP_FILE_UNCOMPRESSED.bz2

# Entity linking results output file
export EL_RESULTS_FILE=$APP_HOME/evaluation/entity-linking/results/out.tsv
