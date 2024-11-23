#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 9 October 2024
# Purpose : Install script for CAT control

et-log "Updating CAT control systemd script..."
cp ../overlay/lib/systemd/system/rigctld.service /lib/systemd/system/
systemctl daemon-reload

et-log "Disable automatic start of rigctl..."
systemctl disable rigctld
