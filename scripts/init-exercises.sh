#!/bin/bash

set -Eeuxo pipefail

notebook_urls=(
  'https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/notebooks/ohjelmointitekniikoita.ipynb'
  'https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/notebooks/suorituskyky.ipynb'
  'https://raw.githubusercontent.com/mistmap/postgresql-training-finnish-2020-10/main/notebooks/jsonb.ipynb'
)

if [ "${DO_INIT_EXERCISES}" != 'true' ] ; then
  echo >&2 "DO_INIT_EXERCISES is not set to 'true'. Skip initialization."
  exit 0
fi

for url in "${notebook_urls[@]}"; do
  wget \
    --timestamping \
    --directory-prefix='/exercises' \
    "${url}"
done
