#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

[ -z "$1" ] && {
  printf "bulk.sh [command]"
  exit 1
}

files=()
for repo in "$GIT_REPOS/"*/; do
  [ -d "$repo" ] || continue

  info "git -C $repo $@"
  git -C "$repo" "$@"
done
