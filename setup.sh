#!/bin/sh

# script to initialize or update a CentOS or Fedora instance
# bootstraps the setup of a newly provisionned VM

# WARNING : you shoud make sure you added your public key to ~/.ssh/authorized_keys before doing that

set -e
set -x


OFFLINE=0

while test $# -gt 0; do
    case "$1" in
       --offline)
            OFFLINE=1
            shift
            ;;
    esac
done


DISTRIB_NAME=$(awk '{print $1}' /etc/redhat-release)

# copy repo files to yum.repos.d directory
# repo files are embedded in the git repository for easier offline usage
find repos-$DISTRIB_NAME -name "*.repo" -exec cp {} /etc/yum.repos.d \;
find repos-$DISTRIB_NAME -name "RPM-GPG*" -exec cp {} /etc/pki/rpm-gpg/ \;

# if we are not doing an offline setup then we may use the downloaders ...
if test $OFFLINE -eq 0
then
  pushd ./downloaders
  for LOCAL_SCRIPT in $(ls *.sh)
  do
    ./$LOCAL_SCRIPT
  done
  popd
fi

pushd ./installers
for LOCAL_SCRIPT in $(ls *.sh)
do
  ./$LOCAL_SCRIPT
done
popd

pushd ./configures
for LOCAL_SCRIPT in $(ls *.sh)
do
  ./$LOCAL_SCRIPT
done
popd

# pip and npm commands may not be available before installers are run
# so we have to use them AFTER installers are run

# if we are not doing an offline setup then we may download pip packages ...
if test $OFFLINE -eq 0
then
  ./pip-download-packages.sh
fi

./pip-install-packages.sh

# if we are not doing an offline setup then we may download node modules ...
if test $OFFLINE -eq 0
then
  ./npm-download-packages.sh
fi

echo "Finished successfully"
