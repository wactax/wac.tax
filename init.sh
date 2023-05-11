#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

if ! [ -x "$(command -v direnv)" ]; then
  curl -sfL https://direnv.net/install.sh | bash
fi

GIT="${GIT:-git@github.com:wactax}"

clone() {
  cd $DIR
  if [ -v 2 ]; then
    dir=$2
    mkdir -p $DIR/$1
    cd $DIR/$1
    name=$1.$2
  else
    name=$1
    dir=$1
  fi

  if [ ! -d "$dir" ]; then
    git clone --recursive --depth=1 $GIT/$name.git $dir
  fi
  cd $DIR
}

clone api
clone doc
clone img
clone node
clone ops os
clone ops soft
clone ops docker
clone styl
clone ui
clone site

echo ${GIT_CONF:-$GIT/conf.example.git}
if [ ! -d "conf" ]; then
  git clone --recursive --depth=1 ${GIT_CONF:-$GIT/conf.example.git} conf
fi

if [ ! -d "pkg" ]; then
  clone pkg
  cd pkg
  direnv allow
  ln -s ../conf/pkg/pkg.yml .
  direnv exec . ./init.coffee
  cd ..
fi
