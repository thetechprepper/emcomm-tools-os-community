#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 8 August 2026
# Purpose : Builds and installs et-user-app
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP="et-user-app"
VERSION="1.0.0"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="${VERSION}"
GIT_URL="https://github.com/thetechprepper/et-user-app.git"
GIT_WORKSPACE="${APP}"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}"

et-log "Installing build dependencies..."
apt install \
  libgtk-3-dev \
  libgtk-3-doc \
  libjson-glib-dev \
  -y

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone ${GIT_URL} ${GIT_WORKSPACE}

cd ${GIT_WORKSPACE}
git checkout ${GIT_TAG}

make

mkdir -v -p "${BIN_DIR}"
cp ${APP} ${BIN_DIR}

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD}
