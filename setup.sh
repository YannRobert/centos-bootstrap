#!/bin/sh

# script to initialize or update a CentOS instance
# bootstraps the setup of a newly provisionned VM
# WARNING : you shoud make sure you added your public key to ~/.ssh/authorized_keys before doing that

set -e

yum update -y

# install EPEL, if already installed, should not exit the script
set +e
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

set -e

yum update -y

yum install -y fail2ban
chkconfig fail2ban on
systemctl restart fail2ban.service

yum install -y htop
yum install -y git
yum install -y mlocate

yum install -y docker-io
# start the docker service on boot
chkconfig docker on 

# we want nslookup 
yum install -y bind-utils

# install httpd-tools to get htpasswd
# install pwgen to generate password
yum install -y httpd-tools pwgen

# install yum-cron to enable automatic updates 
yum -y install yum-cron
chkconfig yum-cron on
systemctl restart yum-cron.service

# Authentication using Key Pair should be allowed
perl -i -pe 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# and authentication using Password should be forbidden
perl -i -pe 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart

