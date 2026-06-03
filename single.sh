#!/usr/bin/env bash

cwd=$(pwd)

[ -z "$1" ] && {
  printf "bulk.sh [command]"
  exit 1
}

[ -z "$1" ] || [ -z "$2" ] && {
  printf "single.sh [repo] [command]"
  exit 1
}

info "git -C ${cwd}/$@"
git -C "${cwd}/$@"
