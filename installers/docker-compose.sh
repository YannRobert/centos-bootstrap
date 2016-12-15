#!/bin/bash
set -e
set -x

# install docker-compose into system files
# the package must have been downloaded into subdirectory first

mkdir -p ../downloaded_resources
cd ../downloaded_resources

DOCKER_COMPOSE_VERSION=1.8.0

cp docker-compose-${DOCKER_COMPOSE_VERSION} /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION}
chmod +x /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION}
ln -sf /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION} /usr/local/bin/docker-compose

cp bash_completion-docker-compose-${DOCKER_COMPOSE_VERSION} /etc/bash_completion.d/docker-compose
