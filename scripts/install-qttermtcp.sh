#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 17 December 2024
# Purpose : Install QtTermTCP
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

APP=qtermtcp
VERSION=latest
DOWNLOAD_FILE=QtTermSource.zip
BIN_FILE=QtTermTCP
INSTALL_DIR="/opt/${APP}-${VERSION}"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"
LINK_PATH="/opt/${APP}"

et-log "Installing QtTermTCP build dependencies..."
apt install \
  qtbase5-dev \
  qtbase5-dev-tools \
  qt5-qmake \
  qtchooser \
  qtmultimedia5-dev \
  libqt5serialport5-dev \
  libfftw3-dev \
  qttools5-dev-tools \
  -y

if [ ! -e ${ET_DIST_DIR}/${DOWNLOAD_FILE} ]; then

  URL=http://www.cantab.net/users/john.wiseman/Downloads/${DOWNLOAD_FILE}

  et-log "Downloading QtTermTCP: ${URL}"
  curl -s -L -o ${DOWNLOAD_FILE} --fail ${URL}

  mv -v ${DOWNLOAD_FILE} ${ET_DIST_DIR}
fi

CWD_DIR=`pwd`

# Only build once
if [ ! -e "${ET_SRC_DIR}/${APP}/${BIN_FILE}" ]; then
  cd ${ET_SRC_DIR}
  mkdir -v ${APP} && cd ${APP}
  unzip ${ET_DIST_DIR}/${DOWNLOAD_FILE}

  et-log "Building QtTermTCP.."
  qmake && make
fi

[ ! -e ${INSTALL_BIN_DIR} ] && mkdir -v -p ${INSTALL_BIN_DIR}
cp -v "${ET_SRC_DIR}/${APP}/${BIN_FILE}" ${INSTALL_BIN_DIR}

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${APP} -t /usr/local

cd $CWD_DIR
