#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
. "$SCRIPT_DIR/vars.sh"

AS_BARE=0

case "$1" in
"help")
  echo "Clones repository from remote server"
  echo "  -b   Clone as bare repository"
  ;;
"-b") AS_BARE=1 ;;
esac

cat "$COLLECTION" | while IFS= read -r repo; do
  [ -d "${GIT_REPOS}/$(basename $repo)" ] && continue

  [[ $AS_BARE -eq 0 ]] && git clone "ssh://${TARGET}${TARGET_GIT_SERVER}/${repo}" "${GIT_REPOS}/${repo}"
  [[ $AS_BARE -eq 1 ]] && git clone "ssh://${TARGET}${TARGET_GIT_SERVER}/${repo}" "${GIT_SERVER}/${repo}" --bare
done
