#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

files=()
for repo in "$GIT_SERVER/"*/; do
  url=$(git --git-dir="$repo" config --get remote.origin.url || true)

  name=$(basename "$repo" /)
  expected="ssh://${TARGET}${TARGET_GIT_SERVER}/${name}"

  if [[ "$url" != "$expected" ]]; then
    info "Configuring ${name} to use ${TARGET} as remote"
    git --git-dir="$repo" config set remote.origin.url "ssh://${TARGET}${TARGET_GIT_SERVER}/${name}"
  fi
done
