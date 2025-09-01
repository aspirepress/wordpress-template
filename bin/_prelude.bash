#!/usr/bin/false
# This file should be sourced, not run

function warn {
    echo "$@" >&2
}

function die() {
    warn "$@"
    exit 1
}

# best used as a debugging tool: I don't recommend sticking RUN before every single command in your scripts
function RUN() {
  [[ -n $DRY_RUN ]] && [[ $DRY_RUN != 0 ]] && _run=echo
  $_run "$@"
}

####

set -o errexit
set -o pipefail
set -o nounset

[[ ${TRACE:-0} != 0 ]] && set -o xtrace

cd $(dirname $0)/..
