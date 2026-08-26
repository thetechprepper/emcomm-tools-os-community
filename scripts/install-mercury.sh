#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 17 July 2026
# Updated : 26 August 2026
# Purpose : Builds and installs the Mercury HF modem
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP="mercury"
VERSION="1.9.13"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="v${VERSION}"
GIT_URL="https://github.com/Rhizomatica/mercury.git"
GIT_WORKSPACE="mercury"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone ${GIT_URL} ${GIT_WORKSPACE}

cd ${GIT_WORKSPACE} && git checkout ${GIT_TAG}

make && make install prefix="${INSTALL_DIR}"

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD}
