#!/bin/sh

#
# this script automate configuration of the HTTP_PROXY into docker
#
# see documentation for docker with systemd
# https://docs.docker.com/engine/articles/systemd/
#

# this script must be run as privileged user
if [ $(id -u) -ne 0 ] ; then
   echo "Error : this script requires sudo"
   exit 16
fi

set -e

if test $# -ne 2
then
    echo "Invalid number of parameters : usage : $0 <proxy_host> <proxy_port>"
    exit 1
fi

PROXY_HOST=$1
PROXY_PORT=$2

echo "Will use http://${PROXY_HOST}:${PROXY_PORT} as the proxy to use with docker"

# create a systemd drop-in directory for the docker service
mkdir -p /etc/systemd/system/docker.service.d/

# Now create a file called /etc/systemd/system/docker.service.d/http-proxy.conf that adds the HTTP_PROXY environment variable
cat << EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://${PROXY_HOST}:${PROXY_PORT}/" "NO_PROXY=localhost,127.0.0.1"
EOF

# Flush changes
sudo systemctl daemon-reload

# Verify that the configuration has been loaded
sudo systemctl show docker --property Environment

# Restart Docker
systemctl restart docker

# pulling the busybox image in order to test everything is fine
docker pull busybox

echo "Done"
exit 0

