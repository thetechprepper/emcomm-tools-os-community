#!/bin/bash
#
# Author  : Clifton Jones
# Date    : 31 December 2025
# Purpose : Run-once script to enable systemd user services on first graphical login
#
# This script enables the et-service-et-api and et-service-mbtileserver
# systemd user services when a new user logs into the graphical environment
# for the first time.

# Enable the systemd user services
systemctl --user enable et-service-et-api
systemctl --user enable et-service-mbtileserver

# Reload systemd user daemon to pick up changes
systemctl --user daemon-reload

# Start the services
systemctl --user start et-service-et-api
systemctl --user start et-service-mbtileserver

# Remove this autostart entry so it doesn't run again
rm -f "${HOME}/.config/autostart/enable-et-systemd-services.desktop"

exit 0
