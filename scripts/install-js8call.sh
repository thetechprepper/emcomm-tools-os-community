#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 6 April 2023
# Updated : 24 October 2024
# Purpose : Install JS8Call
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

VERSION="2.2.0"
FILE="js8call_${VERSION}_20.04_amd64.deb"
URL="http://files.js8call.com/${VERSION}/${FILE}"

et-log "Installing JS8Call dependencies..."
apt install \
  libqt5serialport5 \
  libqt5multimedia5-plugins \
  libqt5widgets5 \
  libqt5multimediawidgets5 \
  libqt5core5a \
  libqt5gui5 \
  libqt5multimedia5 \
  libqt5network5 \
  libqt5printsupport5 \
  libqt5serialport5 \
  libqt5widgets5 \
  libdouble-conversion3 \
  libpcre2-16-0 \
  qttranslations5-l10n \
  libmd4c0 \
  libqt5dbus5 \
  libxcb-xinerama0 \
  libxcb-xinput0 \
  libqt5svg5 \
  qt5-gtk-platformtheme \
  libqt5multimediagsttools5 \
  libgfortran5 \
  -y

if [ ! -e $ET_DIST_DIR/$FILE ]; then
  et-log "Downloading JS8Call: $URL"

  curl -s -L -O --fail $URL

  [ ! -e $ET_DIST_DIR ] && mkdir -v $ET_DIST_DIR

  mv -v $FILE $ET_DIST_DIR
else
  et-log "${FILE} already downloaded. Skipping..."
fi

dpkg -i $ET_DIST_DIR/$FILE

et-log "Updating JS8Call launcher icon to support PNP..."
cp -v ../overlay/usr/share/applications/js8call.desktop /usr/share/applications/
