#!/bin/bash
set -e
set -x

# enables keepcache
# To retain the cache of packages after a successful installation
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Working_with_Yum_Cache.html

sed -i "s/keepcache=0/keepcache=1/g" /etc/yum.conf
