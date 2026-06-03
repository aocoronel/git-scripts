#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

files=()
for repo in "$GIT_REPOS/"*/; do
  url=$(git --git-dir="$repo" config --get "remote.server.url" || true)

  name=$(basename "$repo" /)
  expected="${GIT_SERVER}/${name}"

  if [[ "$url" != "$expected" ]]; then
    info "Configuring $repo to local server"
    git -C "$repo" config set "remote.server.url" "${GIT_SERVER}/${name}"
  fi
done
