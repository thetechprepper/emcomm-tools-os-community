#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 20 November 2025
# Purpose : Install et-predict-app
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=et-predict-app
VERSION=1.2.0
DOWNLOAD_FILE="${APP}_${VERSION}_amd64.deb"

et-log "Installing ${APP} ${VERSION}..."

if [[ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]]; then

  URL="https://github.com/thetechprepper/${APP}/releases/download/${VERSION}/${DOWNLOAD_FILE}"

  download_with_retries ${URL} ${DOWNLOAD_FILE}
  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

DEBIAN_FRONTEND=noninteractive dpkg -i "${ET_DIST_DIR}/${DOWNLOAD_FILE}" 
