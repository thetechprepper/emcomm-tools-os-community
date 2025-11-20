#!/bin/bash
# Author  : William McKeehan
# Date    : 18 November 2025
# Purpose : Builds and installs flamp
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP="flamp"
VERSION="2.2.14"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="v${VERSION}"
GIT_URL="https://git.code.sf.net/p/fldigi/flamp"
GIT_WORKSPACE="flamp"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone ${GIT_URL} ${GIT_WORKSPACE}

cd ${GIT_WORKSPACE}
git checkout ${GIT_TAG}

# Generate config script
autoreconf -i && ./configure --prefix=${INSTALL_DIR}

# Compile
make

# Install
make install

[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local
