#!/bin/bash
# Author  : William McKeehan
# Author  : Gaston Gonzalez
# Date    : 18 November 2025
# Updated : 14 March 2026
# Purpose : Builds and installs flmsg
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP="flmsg"
VERSION="4.0.24"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="v${VERSION}"
GIT_URL="https://git.code.sf.net/p/fldigi/flmsg"
GIT_WORKSPACE="flmsg"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} ${VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone ${GIT_URL} ${GIT_WORKSPACE}

# Fixing a bug in this build of flmsg
sed -i '46 i#include "pthread.h"' /opt/src/flmsg/src/widgets/font_browser.cxx

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

# Use wrapper script as launcher executable
sed -i 's|^Exec.*|Exec=/opt/emcomm-tools/bin/et-flmsg start|' /opt/flmsg/share/applications/flmsg.desktop
cp -v /opt/flmsg/share/applications/flmsg.desktop /usr/share/applications/flmsg.desktop

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD}
