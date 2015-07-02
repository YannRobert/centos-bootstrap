#!/bin/sh

# This script helps set the DNS in the NetworkManager configuration
# NetworkManager will eventually generate /etc/resolv.conf accordingly
# Works on a CentOS distribution

# Just pass the nameserver address to the command line (separated by a space if there are multiple)
# Example Usage: ./configure-nameservers.sh 8.8.8.8 8.8.4.4

set -e
#set -x

if test $# -lt 1
then
   echo "Invalid number of parameters: Usage: $0 <DNS1> <DNS2>"
   exit 1
fi

NAMESERVERS_DEF=$(mktemp)
INDEX=0
for var in "$@"
do
    INDEX=$((INDEX+1))
    echo "DNS${INDEX}=${var}" >> ${NAMESERVERS_DEF}
done

IF_FILES=$(ls /etc/sysconfig/network-scripts/ifcfg-eth*)

for FILE in $IF_FILES
do
   echo "Removing DNS from file $FILE"
   sed -i '/^DNS[1-9]=/d' $FILE
   echo "Adding DNS in file $FILE"
   cat ${NAMESERVERS_DEF} >> $FILE
done

rm ${NAMESERVERS_DEF}

service network restart

echo "Successfully set $# nameservers"
