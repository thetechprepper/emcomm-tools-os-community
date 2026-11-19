#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 17 September 2025
# Updated : 2 October 2025
# Purpose : Builds and installs fldigi
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP="fldigi"
VERSION="4.2.09"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_TAG="v4.2.09"
GIT_URL="https://git.code.sf.net/p/fldigi/fldigi"
GIT_WORKSPACE="fldigi"
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

cd ${CWD_DIR}

# Use wrapper script as launcher executable
sed -i 's|^Exec.*|Exec=/opt/emcomm-tools/bin/et-fldigi start|' /opt/fldigi/share/applications/fldigi.desktop

