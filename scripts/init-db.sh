#!/bin/bash

set -Eeuxo pipefail

declare -A schema_urls
schema_urls=(
  [chinook]='https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/dumps/chinook.sql.xz'
  [hfp]='https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/dumps/hfp.sql.xz'
  [itis]='https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/dumps/itis.sql.xz'
)

if [ "${DO_INIT_DB}" != 'true' ] ; then
  echo >&2 "DO_INIT_DB is not set to 'true'. Skip initialization."
  exit 0
fi

for key in "${!schema_urls[@]}"; do
  wget \
    --output-document='./downloaded' \
    "${schema_urls[$key]}"
  psql '--set=ON_ERROR_STOP=true' << EOF
DROP SCHEMA IF EXISTS "${key}" CASCADE;
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
SET search_path TO public;
$(xzcat './downloaded')
ALTER SCHEMA public RENAME TO "${key}";
EOF
done

psql '--set=ON_ERROR_STOP=true' << EOF
CREATE SCHEMA IF NOT EXISTS public;
VACUUM ANALYZE;
EOF
