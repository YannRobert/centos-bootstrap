#!/bin/bash
yum install -y git
git clone https://github.com/YannRobert/centos-bootstrap.git
cd centos-bootstrap
./setup.sh
