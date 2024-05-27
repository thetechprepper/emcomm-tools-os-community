#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 25 November 2022
# Updated : 19 May 2024
# Purpose : Install hamlib for rig control
set -e

ET_DIST_DIR=/opt/dist
ET_SRC_DIR=/opt/src

VERSION=4.5
APP_AND_VERSION=hamlib-$VERSION
TARBALL=$APP_AND_VERSION.tar.gz
URL=https://github.com/Hamlib/Hamlib/releases/download/$VERSION/$TARBALL
INSTALL_DIR=/opt/$APP_AND_VERSION
LINK_PATH=/opt/hamlib

if [ ! -e $ET_DIST_DIR/$TARBALL ]; then
  et-log "Downloading hamlib: $URL "
  curl -s -L -O --fail $URL

  [ ! -e $ET_DIST_DIR ] && mkdir -v $ET_DIST_DIR
  [ ! -e $ET_SRC_DIR ] && mkdir -v $ET_SRC_DIR

  mv $TARBALL $ET_DIST_DIR
fi

CWD_DIR=`pwd`

cd $ET_SRC_DIR
et-log "Unpacking $ET_DIST_DIR/$TARBALL"
tar -xzf $ET_DIST_DIR/$TARBALL && cd $APP_AND_VERSION

[ ! -e $INSTALL_DIR ] && mkdir -v $INSTALL_DIR

et-log "Building Hamlib $VERSION"
./configure --prefix=$INSTALL_DIR
make && make check && make install

[ -e $LINK_PATH ] && rm $LINK_PATH
ln -v -s $INSTALL_DIR $LINK_PATH

stow -v -d /opt hamlib -t /usr/local

cd $CWD_DIR

