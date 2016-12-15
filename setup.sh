#!/bin/sh

# script to initialize or update a CentOS or Fedora instance
# bootstraps the setup of a newly provisionned VM

# WARNING : you shoud make sure you added your public key to ~/.ssh/authorized_keys before doing that

set -e
set -x

DISTRIB_NAME=$(awk '{print $1}' /etc/redhat-release)

# copy repo files to yum.repos.d directory
# repo files are embedded in the git repository for easier offline usage
find repos-$DISTRIB_NAME -name "*.repo" -exec cp {} /etc/yum.repos.d \;
find repos-$DISTRIB_NAME -name "RPM-GPG*" -exec cp {} /etc/pki/rpm-gpg/ \;

pushd ./downloaders
for LOCAL_SCRIPT in $(ls *.sh)
do
  ./$LOCAL_SCRIPT
done
popd

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
