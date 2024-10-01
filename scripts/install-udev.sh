#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 1 October 2024
# Purpose : Install udev rules for CAT, GPS and audio PnP support
set -e

et-log "Installing udev rules..."
cp -v ../overlay/etc/udev/rules.d/*.rules /etc/udev/rules.d/
udevadm control --reload

et-log "Disable brltty.."
systemctl mask brltty-udev.service
systemctl stop brltty-udev.service
