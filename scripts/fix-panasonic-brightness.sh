#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 January 2023
# Updated : 16 March 2024
# Purpose : Fix screen brightness on Panasonic hardware

et-log "Installing Panasonic brightness fix..."

apt install inotify-tools -y

if [ ! -e $ET_HOME/sbin ]; then
  mkdir -v -p $ET_HOME/sbin
  chown -v $ET_USER:$ET_GROUP $ET_HOME/sbin
fi

cp -v ../overlay/$ET_HOME/sbin/panasonic-set-brightness.sh $ET_HOME/sbin/
chmod -v 755 $ET_HOME/sbin/panasonic-set-brightness.sh
chown -v $ET_USER:$ET_GROUP $ET_HOME/sbin/*

cp -v ../overlay/lib/systemd/system/panasonic-brightness.service /lib/systemd/system/

systemctl daemon-reload
systemctl enable panasonic-brightness
systemctl start panasonic-brightness
