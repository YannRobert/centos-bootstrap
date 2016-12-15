#!/bin/sh

# script to initialize or update a CentOS or Fedora instance
# bootstraps the setup of a newly provisionned VM

# WARNING : you shoud make sure you added your public key to ~/.ssh/authorized_keys before doing that

set -e
set -x

DISTRIB_NAME=$(awk '{print $1}' /etc/redhat-release)

# copy repo files to yum.repos.d directory
# repo files are embedded in the git repository for easier offline usage
cp repos-$DISTRIB_NAME/*.repo /etc/yum.repos.d
cp repos-$DISTRIB_NAME/RPM-GPG* /etc/pki/rpm-gpg/

pushd ./downloaders
for LOCAL_SCRIPT in $(ls *.sh)
do
  ./$LOCAL_SCRIPT
done
popd

./install-apps-common.sh

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

#./pip-download-packages.sh
#./pip-install-packages.sh

echo "Finished successfully"
