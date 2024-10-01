#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 1 October 2022
# Purpose : Configure GPS
set -e

et-log "Installing GPS packages and dependencies..."
apt install gpsd gpsd-clients at -y

et-log "Installing gpsd config..."
cp ../overlay/etc/default/gpsd /etc/default/

et-log "Updating gpsd systemd script..."
cp ../overlay/lib/systemd/system/gpsd.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable gpsd
