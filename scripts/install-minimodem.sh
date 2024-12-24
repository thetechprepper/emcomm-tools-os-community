#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 24 December 2024
# Purpose : Install minimodem
set -e

ET_DIST_DIR=/opt/dist
ET_SRC_DIR=/opt/src

VERSION="0.24-1"
APP="minimodem"
APP_AND_VERSION="${APP}-${VERSION}"
TARBALL="${APP_AND_VERSION}.tar.gz"
URL="https://github.com/kamalmostafa/minimodem/archive/refs/tags/${TARBALL}"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
LINK_PATH="/opt/${APP}"

if [ ! -e ${ET_DIST_DIR}/${TARBALL} ]; then
  et-log "Downloading ${APP}: $URL"
  curl -s -L -O --fail $URL

  mv ${TARBALL} ${ET_DIST_DIR}
fi

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
et-log "Unpacking ${ET_DIST_DIR}/${TARBALL}"
tar -xzf ${ET_DIST_DIR}/${TARBALL} && cd ${APP}-${APP_AND_VERSION}

[ ! -e ${INSTALL_DIR} ] && mkdir -v ${INSTALL_DIR}

et-log "Building ${APP} ${VERSION}"
autoreconf -i
./configure \
  --without-pulseaudio \
  --prefix=${INSTALL_DIR}
make && make check && make install

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd $CWD_DIR

