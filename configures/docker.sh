#!/bin/bash
set -e

getent group docker || groupadd docker
gpasswd -a ${USER} docker
# start the docker service on boot
chkconfig docker on
{
   systemctl start docker.service
} || {
   echo "docker.service failed to start (it may be normal on some VPS managed by OpenVZ)"
}
