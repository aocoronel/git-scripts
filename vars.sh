#!/usr/bin/env bash

get() {
  sed -n "s|^$1=||p" $2
}

current=$(get current repo.ini)
server_home=$(get server repo.ini)
client_home=$(get client repo.ini)
server_name=$(get server_name repo.ini)
client_name=$(get client_name repo.ini)

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
