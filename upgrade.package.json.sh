#!/usr/bin/env bash
set -e

GREEN='\033[32m'
NC='\033[0m' # No Color

for p in $(fd package.json \
  -E ru/lib/neon \
  -E .git \
  -E node_modules \
  -aIHt f); do
  if [[ ! $(echo $p | grep -E '/npm/') ]]; then
    cmd="cd $(dirname $p) && ncu -u && ni"
    echo -e "$GREEN> $cmd$NC"
    bash -c "$cmd"
  fi
done

./git.sync.sh
