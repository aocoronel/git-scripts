#!/usr/bin/env bash

dir=$1

if [ -z $dir ]; then
  echo "bare_to_repo: directory not provided"
  exit 1
fi

cwd=$(pwd)

files=()
for repo in "$cwd/$dir"*/; do
  [ -d "$repo" ] || continue
  git clone "${repo}" "${cwd}/$(basename "$repo")" || info "Already cloned"
done
