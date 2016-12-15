#!/bin/bash
set -e

chkconfig fail2ban on
systemctl restart fail2ban.service
