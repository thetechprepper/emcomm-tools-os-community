#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 16 March 2026
# Purpose : Install Ventoy
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=ventoy
VERSION=1.1.10
FILE=ventoy-${VERSION}-linux.tar.gz
INSTALL_DIR=/opt/${APP}-${VERSION}
LINK_PATH=/opt/${APP}

et-log "Installing ${APP}..."

if [[ ! -e "${ET_DIST_DIR}/${FILE}" ]]; then
  URL=https://sourceforge.net/projects/ventoy/files/v${VERSION}/${FILE}/download

  et-log "Downloading ${APP}: ${URL}"
  download_with_retries ${URL} ${FILE}

  mv -v ${FILE} ${ET_DIST_DIR}
fi

CWD_DIR=$(pwd)

if [[ ! -e ${INSTALL_DIR} ]]; then
  cd /opt && tar -xzf ${ET_DIST_DIR}/${FILE}
else
  et-log "${INSTALL_DIR} already exists."
fi

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

cd ${CWD_DIR}
