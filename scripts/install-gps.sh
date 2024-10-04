#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 1 October 2022
# Updated : 4 October 2024
# Purpose : Configure GPS and time synch
set -e

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

et-log "Enabling gpsd..."
systemctl enable gpsd

et-log "Updating chronyd to support GPS as a time source..."
echo "# ET: Enable GPS as a time source" >> /etc/chrony/chrony.conf
echo "refclock SHM 0 refid GPS poll 4 precision 1e-3 offset 0.128" >> /etc/chrony/chrony.conf
systemctl restart chronyd
