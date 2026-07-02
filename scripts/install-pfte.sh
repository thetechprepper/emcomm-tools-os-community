#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 27 March 2026
# Updated : 15 June 2026
# Purpose : Install Paranoia File & Text Encryption

set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=pfte
VERSION=15.0.8-1
DOWNLOAD_FILE="${APP}_${VERSION}_amd64.deb"

et-log "Installing ${APP} ${VERSION}..."

if [[ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]]; then

  URL="https://paranoiaworks.com/download/pfte_15.0.8-1_amd64.deb"

  download_with_retries ${URL} ${DOWNLOAD_FILE}
  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

DEBIAN_FRONTEND=noninteractive dpkg -i "${ET_DIST_DIR}/${DOWNLOAD_FILE}" 
