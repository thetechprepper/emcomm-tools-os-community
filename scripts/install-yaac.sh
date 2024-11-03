#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 3 November 2024
# Purpose : Install YAAC
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

VERSION=latest
ZIP_FILE=YAAC.zip
INSTALL_DIR=/opt/yaac-${VERSION}
LINK_PATH=/opt/yaac

et-log "Installing YAAC..."

if [ ! -e ${ET_DIST_DIR}/${ZIP_FILE} ]; then

  URL=https://www.ka2ddo.org/ka2ddo/${ZIP_FILE}

  et-log "Downloading YAAC: ${URL}"
  curl -s -L -o ${ZIP_FILE} --fail ${URL}

  [ ! -e ${ET_DIST_DIR} ] && mkdir ${ET_DIST_DIR}
  [ ! -e ${ET_SRC_DIR} ] && mkdir ${ET_SRC_DIR}
  
  mv -v ${ZIP_FILE} ${ET_DIST_DIR}
fi

CWD_DIR=$(pwd)

if [ ! -e ${INSTALL_DIR} ]; then
  mkdir -v ${INSTALL_DIR} && cd ${INSTALL_DIR}
  unzip ${ET_DIST_DIR}/${ZIP_FILE}
else
  et-log "${INSTALL_DIR} already exists."
fi

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

cd ${CWD_DIR}
