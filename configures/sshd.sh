#!/bin/bash
set -e

# Authentication using Key Pair should be allowed
perl -i -pe 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
# and authentication using Password should be forbidden
perl -i -pe 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# make sure sshd service starts on boot
chkconfig sshd on
service sshd restart
