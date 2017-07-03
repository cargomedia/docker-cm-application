#!/usr/bin/env bash
set -e
ACTION="${1:-start}"
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

shift

echo "Run ${ACTION} with args:${@}"
${CURRENT_DIR}/${ACTION}.sh "${@}"
