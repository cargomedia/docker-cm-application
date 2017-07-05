#!/bin/bash -e
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${CURRENT_DIR}/lib.sh

cp ./resources/config/_local.ci.php ./resources/config/local.php
cp ./resources/config/_local.docker.php ./resources/config/local.docker.php
cp ./resources/config/_test.docker.php ./resources/config/test.docker.php

app_wait_services mysql,redis,memcached,mongo,elasticsearch
app_setup "${SHARED_DIR}/setup.done"

./bin/phpunit "${@}"
