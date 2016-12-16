#!/bin/bash
set -e
set -x

tar cvfz downloaded_resources.tar.gz downloaded_resources

tar cvfz yum-cache.tar.gz /var/cache/yum

tar cvfz dnf-cache.tar.gz /var/cache/dnf
