#!/usr/bin/env bash

case "$1" in
  get)
    shift
    sed -n "s|^$1=||p" $2
    ;;
esac
