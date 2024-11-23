#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 January 2023
# Updated : 9 October 2024
# Purpose : Fix screen brightness on Panasonic hardware

et-log "Installing Panasonic brightness fix..."

apt install inotify-tools -y

cp -v ../overlay/lib/systemd/system/panasonic-brightness.service /lib/systemd/system/

systemctl daemon-reload
systemctl enable panasonic-brightness
systemctl start panasonic-brightness
