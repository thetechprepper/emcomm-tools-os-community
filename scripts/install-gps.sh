#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 1 October 2022
# Updated : 6 October 2024
# Purpose : Configure GPS and time synch

et-log "Installing GPS packages and dependencies..."
apt install \
  gpsd \
  gpsd-clients \
  gpsd-tools \
  chrony \
  at \
  -y

et-log "Installing gpsd config..."
cp ../overlay/etc/default/gpsd /etc/default/

et-log "Updating gpsd systemd script..."
cp ../overlay/lib/systemd/system/gpsd.service /lib/systemd/system/
systemctl daemon-reload

et-log "Disable automatic start of gpsd..."
systemctl disable gpsd

et-log "Updating chronyd to support GPS as a time source..."
cp ../overlay/etc/chrony/chrony.conf /etc/chrony/
systemctl restart chronyd
