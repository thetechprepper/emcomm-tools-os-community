#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 17 December 2024
# Purpose : Main installer for EmComm Tools OS Community

. ./env.sh
. ./functions.sh

exitIfNotRoot

./bootstrap.sh
./update-apt.sh

./install-base.sh
./install-dev-tools.sh
./install-browser.sh
./remove-packages.sh
./install-branding.sh

./configure-gnome.sh
./configure-user.sh

./install-emcomm-tools.sh
./fix-panasonic-brightness.sh

./install-hamlib.sh
./install-js8call.sh

./install-udev.sh
./install-gps.sh 
./install-navit.sh
./install-cat.sh

./install-conky.sh

# Install packet tool chain
./install-direwolf.sh
./install-yaac.sh
./install-bbs-client.sh
./install-bbs-server.sh
./install-chattervox.sh
./install-qttermtcp.sh

# Install modems
./install-ardop.sh

./install-winlink.sh

./install-audio-tools.sh

# Add user-specific data
./download-osm-maps.sh
