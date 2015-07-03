#!/bin/sh

set -e
set -x

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

DNS1=$1
DNS2=$2

$PM install -y bind

curl -o /etc/named.conf https://gist.githubusercontent.com/YannRobert/ef8f19b0bc1e7418ec74/raw/d0b6d64d3642b55180e24da5163ea53f22a458e1/named.conf

if test -z "$DNS1"
then
   sed -i "s/8.8.8.8;//g" /etc/named.conf
else
   sed -i "s/8.8.8.8;/$DNS1;/g" /etc/named.conf
fi

if test -z "$DNS2"
then
   sed -i "s/8.8.4.4;//g" /etc/named.conf
else
   sed -i "s/8.8.4.4;/$DNS2;/g" /etc/named.conf
fi

./configure-nameservers.sh 127.0.0.1

chkconfig named on
service named restart

echo "Finished"

