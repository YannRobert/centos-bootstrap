#!/bin/bash
set -e
set -x

# enables keepcache
# To retain the cache of packages after a successful installation
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Working_with_Yum_Cache.html

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
  sed -i "s/keepcache=0/keepcache=1/g" /etc/dnf/dnf.conf
  if grep --quiet "^keepcache=1$" /etc/dnf/dnf.conf
  then
    echo "keepcache was already enabled"
  else
    echo "keepcache=1" >> /etc/dnf/dnf.conf
    echo "keepcache is now enabled"
  fi
else
  sed -i "s/keepcache=0/keepcache=1/g" /etc/yum.conf
fi
