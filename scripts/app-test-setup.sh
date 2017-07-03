#!/usr/bin/env bash
set -e

SHARED_DATA="${SHARED_DATA:-"/data/app"}"
if [ ! -f "$SHARED_DATA/setup.done" ]
then
  composer --no-interaction install
  ./bin/cm app set-config deploy "$(date '+%s')"
  ./bin/cm app setup
  ./bin/cm migration run
  touch "$SHARED_DATA/setup.done"
fi
