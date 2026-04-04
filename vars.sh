#!/usr/bin/env bash

COLLECTION=git.repos
touch "${COLLECTION}"

current=$(sh ./ini_parser.sh get current repo.ini)
phone_home=$(sh ./ini_parser.sh get phone repo.ini)
desktop_home=$(sh ./ini_parser.sh get desktop repo.ini)

if [ "$current" = "desktop" ]; then
  GIT_REPO="${desktop_home}/git"

  TARGET="phone"
  TARGET_GIT="${phone_home}/git/"
  TARGET_GIT_REPOS="${phone_home}/git/repos"
  TARGET_GIT_SERVER="${phone_home}/git/server"
elif [ "$current" = "phone" ]; then
  GIT_REPO="${phone_home}/git"

  TARGET="desktop"
  TARGET_GIT="${desktop_home}/git/"
  TARGET_GIT_REPOS="${desktop_home}/git/repos"
  TARGET_GIT_SERVER="${desktop_home}/git/server"
fi

GIT_SERVER="${GIT_REPO}/server"
GIT_REPOS="${GIT_REPO}/repos"

mkdir -p "${GIT_SERVER}"
mkdir -p "${GIT_REPOS}"

BLUE="$(tput setaf 87)"
RESET=$(tput sgr0)

info() {
  echo -e "${BLUE}$@${RESET}"
}
