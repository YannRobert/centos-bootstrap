#!/bin/sh

# script to install the server tools we commonly need

set -e

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

DISTRIB_NAME=$(awk '{print $1}' /etc/redhat-release)

cat packages-list-common | xargs $PM install -y
cat packages-list-$DISTRIB_NAME | xargs $PM install -y

echo "Finished successfully"
