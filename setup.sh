#!/bin/sh

# script to initialize or update a CentOS instance
# bootstraps the setup of a newly provisionned VM
# this script should also be working on a Fedora distribution.

# WARNING : you shoud make sure you added your public key to ~/.ssh/authorized_keys before doing that

set -e
set -x

# set the system to use UTC timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

$PM update -y

DISTRIB_NAME=$(awk '{print $1}' /etc/redhat-release)

# only install EPEL repository on CentOS distribution
# on other distributions like on Fedora it must be avoided
if test "$DISTRIB_NAME" == "CentOS"
then
   ## install EPEL, if already installed, should not exit the script
   #set +e
   #rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
   #set -e

   # other way to install the EPEL repository
   $PM install -y epel-release
fi

$PM update -y

$PM install -y fail2ban
chkconfig fail2ban on
systemctl restart fail2ban.service

$PM install -y htop
$PM install -y git
$PM install -y mlocate
$PM install -y curl wget

$PM install -y ntp
chkconfig ntpd on
service ntpd restart

# some basic network tools (not installed by default in CentOS minimal installation)
$PM install -y net-tools nc

$PM install -y docker-io
getent group docker || groupadd docker
gpasswd -a ${USER} docker
# start the docker service on boot
chkconfig docker on 
{ 
   systemctl start docker.service 
} || { 
   echo "docker.service failed to start (it may be normal on some VPS managed by OpenVZ)" 
}

# install docker-compose (previously known as fig)
DOCKER_COMPOSE_VERSION=1.4.2
if test ! -f /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION}
then
   curl --fail -v -o /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION} -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`
   chmod +x /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION}
fi
ln -sf /usr/local/bin/docker-compose-${DOCKER_COMPOSE_VERSION} /usr/local/bin/docker-compose

if test ! -f /usr/local/bin/docker-compose
then
   curl -o /etc/bash_completion.d/docker-compose -L https://raw.githubusercontent.com/docker/compose/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose
fi

# install docker-machine
DOCKER_MACHINE_VERSION=0.4.1
if test ! -f /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION}
then
   curl --fail -v -o /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION} -L https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine_linux-amd64
   chmod +x /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION}
fi
ln -sf /usr/local/bin/docker-machine-${DOCKER_MACHINE_VERSION} /usr/local/bin/docker-machine

# we want nslookup 
$PM install -y bind-utils

# install httpd-tools to get htpasswd
# install pwgen to generate password
$PM install -y httpd-tools pwgen

# install yum-cron to enable automatic updates 
yum -y install yum-cron
perl -i -pe 's/^apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
chkconfig yum-cron on
systemctl restart yum-cron.service

# Authentication using Key Pair should be allowed
perl -i -pe 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# and authentication using Password should be forbidden
perl -i -pe 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# make sure sshd service starts on boot
chkconfig sshd on
service sshd restart

# disable the bell (on the console don't ring the bell on user input alert)
perl -i -pe 's/^#set bell-style none/set bell-style none/' /etc/inputrc

# installing pip
$PM install -y python-pip

# upgrading pip
pip install --upgrade pip

# install the Amazon WebServices Command Line Interface
pip install --upgrade awscli

echo "Finished successfully"

