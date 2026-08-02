#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 22 March 2026
# Purpose : Install WSJT-X
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP="wsjtx"
VERSION="2.7.0"
FILE="wsjtx_${VERSION}_amd64.deb"
URL="https://sourceforge.net/projects/wsjt/files/wsjtx-${VERSION}/${FILE}"

et-log "Installing ${APP} ${VERSION}..."

et-log "Installing dependencies..."

apt install \
  fonts-font-awesome \
  fonts-open-sans \
  libboost-filesystem1.74.0 \
  libboost-log1.74.0 \
  libboost-thread1.74.0 \
  libqcustomplot2.0 \
  -y

if [[ ! -e "${ET_DIST_DIR}/${FILE}" ]]; then
  et-log "Downloading ${APP}: ${URL}"
  download_with_retries ${URL} ${FILE}
  mv -v ${FILE} ${ET_DIST_DIR}
fi

dpkg -i "${ET_DIST_DIR}/${FILE}"

et-log "Updating ${APP} launcher icon to support PNP..."
cp -v ../overlay/usr/share/applications/wsjtx.desktop /usr/share/applications/
