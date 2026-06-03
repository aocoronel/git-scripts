#!/usr/bin/env bash

COLLECTION=git.repos
touch "${COLLECTION}"

current=$(sh ./ini_parser.sh get current repo.ini)
server_home=$(sh ./ini_parser.sh get server repo.ini)
client_home=$(sh ./ini_parser.sh get client repo.ini)
server_name=$(sh ./ini_parser.sh get server_name repo.ini)
client_name=$(sh ./ini_parser.sh get client_name repo.ini)

if [ "$current" = "client" ]; then
  GIT_REPO="${client_home}/git"
  TARGET="server"
  TARGET_GIT="${server_home}/git/"
  TARGET_GIT_REPOS="${server_home}/git/repos"
  TARGET_GIT_SERVER="${server_home}/git/server"
  REMOTE_NAME="${server_name}"
elif [ "$current" = "server" ]; then
  GIT_REPO="${server_home}/git"
  TARGET="client"
  TARGET_GIT="${client_home}/git/"
  TARGET_GIT_REPOS="${client_home}/git/repos"
  TARGET_GIT_SERVER="${client_home}/git/server"
  REMOTE_NAME="${client_name}"
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
