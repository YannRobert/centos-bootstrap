#!/bin/sh

# this script finds the current date and time in the HTTP response header of a google website
# and use it to set the system datetime
# this script is very usefull when the machine does not have access to NTP services on the internet, but have a limited access to the web (generally through a HTTP proxy)
# the script may be placed in /etc/cron.hourly so that it is executed frequently enough

#export https_proxy=http://proxy-host:proxy-post
#export http_proxy=http://proxy-host:proxy-post

set -e

WEBSITE_URL="https://www.google.com"
httpdate="$(wget -S -O /dev/null $WEBSITE_URL 2>&1 | sed -n -e 's/  *Date: *//p' -eT -eq)"
if [ ! -z "$httpdate" ]
then
   echo "According to $WEBSITE_URL, the current time is $httpdate"
   sudo date -s "$httpdate" && date
fi

