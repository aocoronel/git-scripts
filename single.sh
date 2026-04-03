#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

[ -z "$1" ] && {
  printf "bulk.sh [command]"
  exit 1
}

[ -z "$1" ] || [ -z "$2" ] && {
  printf "single.sh [repo] [command]"
  exit 1
}

info "git -C ${GIT_REPOS}/$@"
git -C "${GIT_REPOS}/$@"
