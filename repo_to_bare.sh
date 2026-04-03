#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

files=()
for repo in "$GIT_REPOS/"*/; do
  [ -d "$repo" ] || continue
  git clone  "$repo" "${GIT_SERVER}/$(basename "$repo")" --bare || info "Already cloned"
done

