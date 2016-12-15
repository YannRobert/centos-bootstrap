#!/bin/bash
set -e
set -x

# download docker-compose into a local subdirectory
mkdir -p ../downloaded_resources/docker-compose
cd ../downloaded_resources/docker-compose

DOCKER_COMPOSE_VERSION=1.8.0

# the file is only downloaded if it does not exists or if the file is older than the one on the server
curl --fail -v -z docker-compose-${DOCKER_COMPOSE_VERSION} -o docker-compose-${DOCKER_COMPOSE_VERSION} -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`

curl --fail -v -z bash_completion-docker-compose-${DOCKER_COMPOSE_VERSION} -o bash_completion-docker-compose-${DOCKER_COMPOSE_VERSION} -L https://raw.githubusercontent.com/docker/compose/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose
