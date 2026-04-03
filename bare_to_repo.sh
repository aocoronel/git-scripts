#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

files=()
for repo in "$GIT_SERVER/"*/; do
  [ -d "$repo" ] || continue
  git clone "${repo}" "${GIT_REPOS}/$(basename "$repo")" || info "Already cloned"
done
