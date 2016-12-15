#!/bin/bash
set -e

if test -f /etc/yum/yum-cron.conf
then
  perl -i -pe 's/^apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
  perl -i -pe 's/^update_cmd = default/update_cmd = minimal-security/' /etc/yum/yum-cron.conf
  chkconfig yum-cron on
  systemctl restart yum-cron.service
fi
