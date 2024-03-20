#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Purpose : Minimal bootstrap script for the installer

[ ! -d $ET_HOME/bin ] && mkdir -v -p $ET_HOME/bin

cp -v ../overlay/$ET_HOME/bin/et-log $ET_HOME/bin/
[ ! -e /usr/local/bin/et-log ] && ln -v -s $ET_HOME/bin/et-log /usr/local/bin/et-log

et-log "Starting EmComm Tools OS Community installation"

