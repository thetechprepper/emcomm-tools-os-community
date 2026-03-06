#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 6 March 2026
# Purpose : Main installer for EmComm Tools Community (ETC)

. ./env.sh
. ./functions.sh

exitIfNotRoot

./bootstrap.sh
./update-apt.sh

./install-base.sh
./install-dev-tools.sh
./install-pup.sh
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
./install-packet.sh

# Install modems
./install-ardop.sh

./install-winlink.sh

./install-audio-tools.sh

# Offline KBs (Cyberdeck)
./install-wikipedia.sh

# Add user-specific data
./download-osm-maps.sh
[ ! -z "${ET_EXPERT}" ] && ./download-wikipedia.sh

./install-wine.sh

# Install GIS applications and dependencies
./install-mbtileserver.sh
./install-python.sh
./install-mbutil.sh
./install-gis-tools.sh

# Install RF analysis and prediction tools
./install-rf-analysis-tools.sh

# Install SDR tools
./install-sdr-tools.sh
./install-dump1090.sh

# Install ETC custom maps
./download-et-maps.sh

# Install ETC applications
./install-et-api.sh
./install-et-aircraft.sh
./install-et-predict.sh

# Install documentation tools
./install-dictionary.sh
#./install-doc-tools.sh

# Install prediction tools
./install-voacap.sh

# Install fldigi suite
./install-fldigi.sh
./install-flmsg.sh
./install-flamp.sh
./install-et-portaudio.sh

# Instal SIGINT tools
./install-artemis.sh
./install-minimodem.sh

# Install security tools
./install-gpa.sh
