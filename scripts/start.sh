#!/bin/bash -e
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${CURRENT_DIR}/lib.sh

cp ./resources/config/_local.dev.php ./resources/config/local.php
cp ./resources/config/_local.docker.php ./resources/config/local.docker.php

app_wait_services mysql,redis,memcached,mongo,elasticsearch,gearman
app_setup "${DATA_DIR:-/tmp}/setup.done"

echo 'Start supervisord'
supervisord -c /etc/supervisor.conf
