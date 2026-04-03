#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 15 February 2025
# Updated : 7 March 2025
# Purpose : Install Artemis
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=artemis
VERSION=4.1.0
ZIP_FILE=Artemis-Linux-x86_64-${VERSION}.zip
INSTALL_DIR=/opt/${APP}-${VERSION}
LINK_PATH=/opt/${APP}

et-log "Installing ${APP}..."

et-log "Installing dependencies..."
apt install \
  libxcb-cursor0 \
  -y

if [[ ! -e "${ET_DIST_DIR}/${ZIP_FILE}" ]]; then
  URL=https://github.com/AresValley/Artemis/releases/download/v${VERSION}/${ZIP_FILE}

  et-log "Downloading ${APP}: ${URL}"
  download_with_retries ${URL} ${ZIP_FILE}

  mv -v ${ZIP_FILE} ${ET_DIST_DIR}
fi

CWD_DIR=$(pwd)

if [[ ! -e ${INSTALL_DIR} ]]; then
  mkdir -v ${INSTALL_DIR} && cd ${INSTALL_DIR}
  unzip ${ET_DIST_DIR}/${ZIP_FILE}
else
  et-log "${INSTALL_DIR} already exists."
fi

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

cd ${CWD_DIR}

et-log "Installing ${APP} launcher icon..."
cp -v ../overlay/usr/share/applications/artemis.desktop /usr/share/applications/
