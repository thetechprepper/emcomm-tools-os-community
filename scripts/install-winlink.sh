#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 11 January 2023
# Updated : 4 November 2024
# Purpose : Install Pat Winlink client 
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

VERSION=0.16.0
FILE="pat_${VERSION}_linux_amd64.deb"

et-log "Installing Pat Winlink client version ${VERSION}..."

TARGET_PATH="${ET_DIST_DIR}/${FILE}"

if [ ! -e ${TARGET_PATH} ]; then

  URL="https://github.com/la5nta/pat/releases/download/v${VERSION}/${FILE}"

  et-log "Downloading: ${URL}"
  curl -s -L -o ${FILE} --fail ${URL}

  [ ! -e ${ET_DIST_DIR} ] && mkdir ${ET_DIST_DIR}
  [ ! -e ${ET_SRC_DIR} ] && mkdir ${ET_SRC_DIR}

  mv -v ${FILE} ${ET_DIST_DIR}
fi

et-log "Installing: ${TARGET_PATH}"
dpkg -i ${TARGET_PATH}
