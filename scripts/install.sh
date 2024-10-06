#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 6 October 2024
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

./fix-panasonic-brightness.sh

./install-hamlib.sh
./install-js8call.sh

./install-udev.sh
./install-gps.sh 
./install-navit.sh

./install-conky.sh
