#!/usr/bin/env bash
# This is the default entrypoint for the official Prefect Docker image

set -e

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ ! -z "$EXTRA_PIP_PACKAGES" ]; then
  echo "+uv pip install $EXTRA_PIP_PACKAGES"
  uv pip install --system $EXTRA_PIP_PACKAGES
fi

if [ -z "$*" ]; then
  echo "\
  ___ ___ ___ ___ ___ ___ _____ 
 | _ \ _ \ __| __| __/ __|_   _|
 |  _/   / _|| _|| _| (__  | |  
 |_| |_|_\___|_| |___\___| |_|  

"
  exec bash --login
  prefect server start --host 0.0.0.0
  prefect config set PREFECT_API_URL=https://prefect-savr.onrender.com/api
else
  exec "$@"
fi
