#!/bin/bash
set -e
set -x

# download docker-machine into a local subdirectory
mkdir -p ../downloaded_resources
cd ../downloaded_resources

DOCKER_MACHINE_VERSION=0.8.1

# the file is only downloaded if it does not exists or if the file is older than the one on the server
curl --fail -v -z docker-machine-${DOCKER_MACHINE_VERSION} -o docker-machine-${DOCKER_MACHINE_VERSION} -L https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m`
