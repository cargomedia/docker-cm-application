#!/bin/bash -e
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ACTION="${1:-start}"
export FORCE_SETUP=${FORCE_SETUP:-0}
export FORCE_RELOAD=${FORCE_RELOAD:-0}
if [ "${FORCE_RELOAD}" == '1' ]; then
  FORCE_SETUP='1'
fi


shift
echo "Run ${ACTION}"
if [ "$#" -ne 0 ]; then
    echo "- arguments: ${@}"
fi
echo "- FORCE_SETUP: ${FORCE_SETUP}"
echo "- FORCE_RELOAD: ${FORCE_RELOAD}"

${CURRENT_DIR}/${ACTION}.sh "${@}"
