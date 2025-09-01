#!/usr/bin/false
# This file should be sourced, not run

[[ -n $TRACE ]] && [[ $TRACE != 0 ]] && set -o xtrace

set -o errexit
set -o pipefail
# set -o nounset    # too strict IMHO: it breaks the basic shell idiom of [[ -n $SOMEOPTION ]]

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

cd $(dirname $0)/..
