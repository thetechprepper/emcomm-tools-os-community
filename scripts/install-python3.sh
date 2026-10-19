#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 16 October 2026
# Purpose : Builds and installs Python 3.11.x from source.
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP="python"
VERSION="3.11.17"
APP_AND_VERSION="${APP}-${VERSION}"
TARBALL="Python-${VERSION}.tgz"
URL="https://www.python.org/ftp/python/${VERSION}/${TARBALL}"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
LINK_PATH="/opt/${APP}"

et-log "Installing dependencies for ${APP}..."
apt install \
  libssl-dev \
  libbz2-dev \
  libffi-dev \
  liblzma-dev \
  libreadline-dev \
  libsqlite3-dev \
  zlib1g-dev \
  tk-dev \
  -y

et-log "Installing ${APP} ${VERSION}"

if [[ ! -e $ET_DIST_DIR/$TARBALL ]]; then
  et-log "Downloading ${APP} ${VERSION}: $URL "
  download_with_retries ${URL} ${TARBALL}

  mv ${TARBALL} ${ET_DIST_DIR}
fi

# Remove existing install and source directories
[[ -e "${LINK_PATH}" ]] && rm -v ${LINK_PATH}
[[ -e "${INSTALL_DIR}" ]] && rm -rfv "${INSTALL_DIR}"
[[ -e "${ET_SRC_DIR}/${APP_AND_VERSION}" ]] && rm -rfv "${ET_SRC_DIR}/${APP_AND_VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}

et-log "Unpacking ${ET_DIST_DIR}/${TARBALL}"
tar -xzf ${ET_DIST_DIR}/${TARBALL} && mv Python-${VERSION} ${APP_AND_VERSION}

cd ${APP_AND_VERSION}

mkdir -pv ${INSTALL_DIR}

et-log "Building ${APP} ${VERSION}"
./configure --prefix=${INSTALL_DIR} --with-ensurepip=install
make -j$(nproc) && make altinstall

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

# Do not use stow and symlinks as we don't want this version in the path.
# Applications that need Python 3.11.x should explicitly use this version.
#stow -v -d /opt ${APP} -t /usr/local

cd ${CWD_DIR}
