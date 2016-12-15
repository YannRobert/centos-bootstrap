#!/bin/sh

# script to install the basic desktop tools we commonly need

set -e

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

cat packages-list-desktop | xargs $PM install -y

echo "Finished successfully"
