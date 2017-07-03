#!/usr/bin/env bash
set -e

SHARED_DATA=${SHARED_DATA:-"/data/app"}
if [ ! -f "$SHARED_DATA/setup.done" ]
then
  # supervisor configuration
  mkdir -p /var/log/app
  foreman export -u root supervisord /etc/supervisor/conf.d
  # CM setup
  composer up
  ./bin/cm app generate-config-internal
  ./bin/cm app setup --reload
  touch "$SHARED_DATA/setup.done"
fi
