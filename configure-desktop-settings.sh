#!/bin/sh

# script to configure common settings on desktop machines

set -e

# set the system to use Europe/Paris timezone
sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true

gsettings set org.gnome.desktop.datetime automatic-timezone false

gsettings set org.gnome.system.locale region 'fr_FR.utf8'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+oss')]"

