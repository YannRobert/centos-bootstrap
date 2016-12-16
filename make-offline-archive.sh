#!/bin/bash
set -e
set -x

if test -f downloaded_resources
then
  tar cvfz downloaded_resources.tar.gz downloaded_resources
fi

TARGET_DIR=$(pwd)

if test -d /var/cache/dnf
then
  pushd /var/cache/
  tar cvfz $TARGET_DIR/yum-cache.tar.gz yum
  popd
fi

if test -d /var/cache/dnf
then
  pushd /var/cache/
  tar cvfz $TARGET_DIR/dnf-cache.tar.gz dnf
  popd
fi
