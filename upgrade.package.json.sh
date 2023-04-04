#!/usr/bin/env bash
set -e

GREEN='\033[32m'
NC='\033[0m' # No Color

for p in $(fd package.json \
  -E ru/lib/neon \
  -E .git \
  -E node_modules \
  -aIHt f); do
  cmd="cd $(dirname $p) && ncu -u && ni"
  echo -e "$GREEN> $cmd$NC"
  bash -c "$cmd"
done

./git.sync.sh
