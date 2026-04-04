#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

while getopts ":-f" opt; do
  case "$opt" in
  -)
    break
    ;;
  f)
    FORCE=1
    ;;
  ?)
    echo "Error: Invalid option '-$OPTARG'" >&2
    exit 1
    ;;
  esac
done

shift $((OPTIND - 1))

if [ -n "$FORCE" ]; then
  OPERATION=delete
else
  OPERATION=update
fi

if [[ "$(uname -a)" =~ "Android" ]]; then
  rsync -avzrPl --"$OPERATION" "$GIT_REPO" "desktop:$TARGET_GIT"
else
  rsync -e 'ssh -p 8022' -avzrPl --"$OPERATION" "$GIT_REPO" "phone:$TARGET_GIT"
fi
