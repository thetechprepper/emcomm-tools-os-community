#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 6 October 2024
# Purpose : Install EmComm Tools applications

et-log "Installing EmComm Tools applications..."

if [ ! -e $ET_HOME ]; then
  mkdir -v -p $ET_HOME
fi

cp -v -r ../overlay/$ET_HOME/* $ET_HOME
chown -v -R $ET_USER:$ET_GROUP $ET_HOME
