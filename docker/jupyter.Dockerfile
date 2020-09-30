FROM jupyter/minimal-notebook@sha256:e0379b8cb97327c7a0baf7cb53d0f411b5b950584aa2e2d69cc96b61ee9c9120

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    'pgformatter=4.2-1' \
    'pgtap=1.1.0-2' \
    # For psql
    'postgresql-client=12+214ubuntu0.1' \
    # For postgres_kernel
    'libpq-dev=12.4-0ubuntu0.20.04.1' \
  && rm -rf /var/lib/apt/lists/*

# Valid on 2020-09-29:
# https://discourse.jupyter.org/t/how-do-i-enable-a-bash-kernel/1718/2
RUN pip install 'bash_kernel==0.7.2' \
  && python -m bash_kernel.install \
  # The original package seems broken at the moment so use what seems to work.
  && pip install 'git+https://github.com/mistmap/postgres_kernel@0.2.2-docker-installable-2020-09-29' \
  && python -m postgres_kernel.install \
  && rm -rf "/home/${NB_USER}/.local" \
  && fix-permissions "${CONDA_DIR}" \
  && fix-permissions "/home/${NB_USER}"

USER "${NB_UID}"

RUN pip install --no-cache \
  'ipython-sql==0.4.0' \
  # For psql commands for ipython-sql
  'pgspecial==1.11.10' \
  # For an autocomplete tool
  'pgcli==3.0.0'
