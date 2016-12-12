#!/bin/bash

#set -e
set -x

docker rm --force squid

docker run -d --net bridge -p 8000:8000 -v ~/squid-cache:/var/cache/squid-deb-proxy -v /etc/localtime:/etc/localtime:ro --name squid yasn77/docker-squid-repo-cache

