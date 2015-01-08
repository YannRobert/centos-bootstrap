#!/bin/sh

# this script must be run as privileged user

set -e

if test $# -ne 2
then
    echo "Invalid number of parameters : usage : $0 <proxy_host> <proxy_port>"
    exit 1
fi

PROXY_HOST=$1
PROXY_PORT=$2

echo "Will use http://${PROXY_HOST}:${PROXY_PORT} as the proxy to use with docker"

sed -i '/^HTTP_PROXY=/d' /etc/sysconfig/docker
sed -i '/^HTTPS_PROXY=/d' /etc/sysconfig/docker

echo "HTTP_PROXY=\"http://192.168.96.21:8002\"" >> /etc/sysconfig/docker
echo "HTTPS_PROXY=\"$HTTP_PROXY\"" >> /etc/sysconfig/docker

# restart the docker service
service docker restart

# pulling the busybox image in order to test everything is fine
docker pull busybox

echo "Done"
exit 0

