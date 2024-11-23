#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 5 November 2024
# Purpose : Install ARDOP modem
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

VERSION=1.0.4.1.3
DOWNLOAD_FILE=ardopcf_amd64_Linux_64
BIN_FILE=ardopcf
INSTALL_DIR=/opt/ardop-${VERSION}
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH=/opt/ardop

et-log "Installing ARDOP..."

if [ ! -e ${INSTALL_BIN_DIR} ]; then
   et-log "Creating ARDOP install directory: ${INSTALL_BIN_DIR}"
   mkdir -v -p ${INSTALL_BIN_DIR}
fi

if [ ! -e ${INSTALL_BIN_DIR}/${BIN_FILE} ]; then
  URL="https://github.com/pflarue/ardop/releases/download/${VERSION}/${DOWNLOAD_FILE}"

  et-log "Downloading ARDOP: ${URL}"
  curl -s -L -o ${BIN_FILE} --fail ${URL}
  
  mv -v ${BIN_FILE} ${INSTALL_BIN_DIR}
fi

chmod 755 ${INSTALL_BIN_DIR}/${BIN_FILE}

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ardop -t /usr/local
