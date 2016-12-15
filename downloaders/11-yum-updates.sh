#!/bin/bash
set -e
set -x

# if dnf is available, then use dnf, otherwise use yum, as the package manager command
PM=yum
if test -f /usr/bin/dnf
then
   PM=dnf
fi

$PM update -y --downloadonly
