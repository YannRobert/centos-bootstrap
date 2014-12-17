#!/bin/sh

# script to initialize or update a CentOS instance
# bootstraps the setup of a newly provisionned VM

set -e

yum update -y

# install EPEL, if already installed, should not exit the script
set +e
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

set -e

yum update -y

yum install -y fail2ban
service fail2ban restart

yum install -y git
yum install -y mlocate

yum install -y docker-io

# we want nslookup 
yum install -y bind-utils

