#!/bin/bash
set -e

chkconfig ntpd on
service ntpd restart
