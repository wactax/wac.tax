#!/usr/bin/env bash

DIR=$(realpath ${0%/*})
cd $DIR
set -ex

GREEN='\033[32m'
NC='\033[0m' # No Color

git_sync() {
  for p in $(fd "^.git$" \
    -E node_modules \
    -aIHt d); do

    to=$(dirname $p)

    if grep -F -q "git@github.com:wac" $to/.git/config; then
      echo -e "$GREEN> $to$NC"

      if [ -n "$1" ]; then
        msg=${@:1}
      else
        msg=♨
      fi

      cmd="cd $to && git add . && git commit -m'$msg' ; git pull && git push"
      echo $cmd
      bash -c "$cmd" &
    fi
  done
  wait
}

bunx mdt zh
git_sync

./init.coffee
bunx i18n

git_sync
