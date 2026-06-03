#!/usr/bin/env bash

cwd=$(pwd)

[ -z "$1" ] && {
  printf "bulk.sh [command]"
  exit 1
}

files=()
for repo in "$cwd/"*/; do
  [ -d "$repo" ] || continue

  info "git -C $repo $@"
  git -C "$repo" "$@"
done
