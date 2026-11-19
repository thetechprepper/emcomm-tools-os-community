#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 28 June 2026
# Purpose : Installs modem73
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP="modem73"
VERSION="1.0.7"
APP_AND_VERSION="${APP}-${VERSION}"
GIT_URL="https://github.com/thetechprepper/modem73.git"
GIT_WORKSPACE="modem73"
INSTALL_DIR="/opt/${APP_AND_VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

et-log "Installing ${APP} dependencies..."
apt install \
  libncurses-dev \
  -y

et-log "Installing ${APP} ${VERSION}"

CWD_DIR=`pwd`

cd ${ET_SRC_DIR}
[[ ! -e ${GIT_WORKSPACE} ]] && git clone --branch emcomm-tools --single-branch ${GIT_URL}

cd ${GIT_WORKSPACE}
make

[[ ! -e "${INSTALL_BIN_DIR}" ]] && mkdir -v -p "${INSTALL_BIN_DIR}"
[[ -e "${APP}" ]] && cp ${APP} "${INSTALL_BIN_DIR}"


[[ -e ${LINK_PATH} ]] && rm ${LINK_PATH}
ln -v -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD}


et-log "Enabling modem73 interface..."

INTERFACE_FILE=Modem73Interface.py
INTERFACE_DIR=/etc/skel/.reticulum/interfaces

download_with_retries https://raw.githubusercontent.com/thetechprepper/modem73interface/refs/heads/master/Modem73Interface.py ${INTERFACE_FILE}

[[ ! -e ${INTERFACE_DIR} ]] && mkdir -v -p ${INTERFACE_DIR}
mv -v ${INTERFACE_FILE} /etc/skel/.reticulum/interfaces

