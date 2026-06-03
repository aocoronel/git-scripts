#!/usr/bin/env bash

cwd=$(pwd)

files=()
for repo in "$cwd/"*/; do
  [ -d "$repo" ] || continue
  git clone "${repo}" "${cwd}/$(basename "$repo")" || info "Already cloned"
done
