#!/bin/bash
#
# Author  : William McKeehan
# Date    : 3 September 2025
# Purpose : Install SDR++
set -e

et-log "Installing SDR++ ..."

. ./env.sh

APP=sdrpp
REPO=https://github.com/AlexandreRouma/SDRPlusPlus/releases/download/nightly/sdrpp_ubuntu_jammy_amd64.deb
REPO_SRC_DIR="${ET_SRC_DIR}/${APP}"

[[ ! -e ${ET_SRC_DIR} ]] && mkdir ${ET_SRC_DIR}

CWD_DIR=`pwd`

et-log "Installing ${APP} ..."

et-log "Cloning ${APP} repository..."
if [[ ! -e ${REPO_SRC_DIR} ]]; then
  mkdir ${REPO_SRC_DIR} 
fi

cd ${REPO_SRC_DIR}

wget ${REPO}

dpkg -i sdrpp_ubuntu_jammy_amd64.deb

apt install -f -y

cd ${CWD_DIR}
