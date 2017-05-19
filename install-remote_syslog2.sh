#!/bin/sh

set -e

if [ $(id -u) -ne 0 ] ; then
   echo "Error : this script requires sudo"
   exit 16
fi

TARGET_FILE=remote_syslog_linux_amd64.tar.gz
ARCHIVE_URL=https://github.com/papertrail/remote_syslog2/releases/download/v0.16/${TARGET_FILE}

wget -O ${TARGET_FILE} $ARCHIVE_URL
#curl -o ${TARGET_FILE} ${ARCHIVE_URL}

tar -xvf ${TARGET_FILE}

cp ./remote_syslog/remote_syslog /usr/local/bin

rm -rf ./remote_syslog
#rm remote_syslog_linux_amd64.tar.gz

# see https://github.com/papertrail/remote_syslog2/blob/master/examples/remote_syslog.systemd.service
cat << EOF > /etc/systemd/system/remote_syslog.service
[Unit]
Description=remote_syslog2
Documentation=https://github.com/papertrail/remote_syslog2
After=rsyslog.service

[Service]
ExecStartPre=/usr/bin/test -e /etc/log_files.yml
ExecStart=/usr/local/bin/remote_syslog -D
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

systemctl enable remote_syslog.service
systemctl start remote_syslog.service

echo "Success"
