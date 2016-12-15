#!/bin/bash
set -e
set -x

# install docker-machine into system files
# the package must have been downloaded into subdirectory first

mkdir -p ../downloaded_resources
cd ../downloaded_resources

DOCKER_MACHINE_VERSION=0.8.1

cp docker-machine-${DOCKER_MACHINE_VERSION} /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION}
chmod +x /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION}
ln -sf /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION} /usr/local/bin/docker-machine
