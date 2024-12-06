#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 4 December 2024
# Purpose : Install chattervox protocol
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

NAME=chattervox
VERSION=0.7.0
TARBALL=chattervox-linux-x64.tar.gz
INSTALL_DIR="/opt/${NAME}-${VERSION}"
LINK_PATH="/opt/${NAME}"

et-log "Installing ${NAME} ${VERSION}..."

URL=https://github.com/brannondorsey/chattervox/releases/download/v${VERSION}/chattervox-linux-x64.tar.gz

et-log "Downloading: ${URL}"
curl -s -L -o ${TARBALL} --fail ${URL}

CWD_DIR=`pwd`

tar -xzf ${TARBALL} 

if [ -e chattervox-linux-x64 ]; then
  mv chattervox-linux-x64 ${INSTALL_DIR}
  mkdir -p ${INSTALL_DIR}/bin
  mv ${INSTALL_DIR}/chattervox ${INSTALL_DIR}/bin/
  mv ${INSTALL_DIR}/serialport.node ${INSTALL_DIR}/bin/
  rm -v ${TARBALL}
fi

[ -e ${LINK_PATH} ] && rm ${LINK_PATH}
ln -s ${INSTALL_DIR} ${LINK_PATH}

stow -v -d /opt ${NAME} -t /usr/local

cd $CWD_DIR
