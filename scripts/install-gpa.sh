#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 6 March 2026
# Purpose : Install GNU Privacy Assistant
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=gpa
VERSION=0.11.1
DOWNLOAD_FILE="${APP}-${VERSION}.tar.bz2"
URL="https://www.gnupg.org/ftp/gcrypt/gpa/${DOWNLOAD_FILE}"
INSTALL_DIR=/opt/${APP}-${VERSION}
LINK_PATH=/opt/${APP}

et-log "Installing ${APP} ${VERSION}..."

et-log "Installing build dependencies..."
apt install \
  libgtk-3-dev \
  libgpg-error-dev \
  libgpgme-dev \
  -y

if [[ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]]; then
  et-log "Downloading ${URL}"
  download_with_retries ${URL} ${DOWNLOAD_FILE}
  mv ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
tar -xjf ${ET_DIST_DIR}/${DOWNLOAD_FILE} && cd ${APP}-${VERSION}

[[ ! -e ${INSTALL_DIR} ]] && mkdir -v ${INSTALL_DIR}

./configure --prefix=${INSTALL_DIR}
make && make install

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD_DIR}
