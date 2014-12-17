#!/bin/sh

# script to initialize or update a CentOS instance
# bootstraps the setup of a newly provisionned VM

set -e

yum update -y

rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum update -y

yum install -y fail2ban
service fail2ban restart

yum install -y git
yum install -y mlocate

yum install -y docker-io

