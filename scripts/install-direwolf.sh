#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 27 March 2023
# Updated : 27 November 2024
# Purpose : Install Dire Wolf
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

VERSION=1.7
TARBALL=direwolf-$VERSION.tar.gz
INSTALL_DIR=/opt/direwolf-$VERSION
LINK_PATH=/opt/direwolf

et-log "Installing Dire Wolf build dependencies..."
apt install \
  gcc \
  g++ \
  make \
  cmake \
  libasound2-dev \
  libudev-dev \
  -y

if [ ! -e $ET_DIST_DIR/$TARBALL ]; then

  URL=https://github.com/wb2osz/direwolf/archive/refs/tags/${VERSION}.tar.gz

  et-log "Downloading Dire Wolf version: $URL"
  curl -s -L -o $TARBALL --fail $URL

  [ ! -e $ET_DIST_DIR ] && mkdir $ET_DIST_DIR
  [ ! -e $ET_SRC_DIR ] && mkdir $ET_SRC_DIR
  
  mv -v $TARBALL $ET_DIST_DIR
fi

CWD_DIR=`pwd`

cd $ET_SRC_DIR
tar -xzf $ET_DIST_DIR/$TARBALL && cd direwolf-$VERSION

[ ! -e $INSTALL_DIR ] && mkdir -v $INSTALL_DIR

[ -e build ] && rm -rf build
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_DIR ..
make -j4
make install
make install-conf

[ -e $LINK_PATH ] && rm $LINK_PATH
ln -s $INSTALL_DIR $LINK_PATH

stow -v -d /opt direwolf -t /usr/local

cd $CWD_DIR

