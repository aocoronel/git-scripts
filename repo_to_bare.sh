#!/usr/bin/env bash

cwd=$(pwd)

files=()
for repo in "$cwd/"*/; do
  [ -d "$repo" ] || continue
  git clone  "$repo" "${GIT_SERVER}/$(basename "$repo")" --bare || info "Already cloned"
done
