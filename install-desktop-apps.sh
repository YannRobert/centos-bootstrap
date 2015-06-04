#!/bin/sh

# script to install the basic desktop tools we commonly need

set -e

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm || true

cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

cat packages-list-desktop | xargs $PM install -y

echo "Finished successfully"

