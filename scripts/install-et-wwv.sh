#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 April 2026
# Purpose : Install et-wwv
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

APP=et-wwv
REPO=https://github.com/thetechprepper/et-wwv.git
REPO_DIR="${ET_SRC_DIR}/${APP}"

CWD_DIR=`pwd`

if [[ ! -e "${REPO_DIR}" ]]; then
  et-log "Cloning ${APP} repository..."
  cd ${ET_SRC_DIR} && git clone ${REPO}
fi 

et-log "Building ${APP}..."
cd ${REPO_DIR} && ./build.sh

mkdir -p "/opt/${APP}/bin"
cp build/et-wwv /opt/${APP}/bin/

stow -v -d /opt ${APP} -t /usr/local

cd ${CWD_DIR}
