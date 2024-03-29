#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Purpose : Updates the apt repository

et-log "Updating apt to use the old repository"

cp -v ../overlay/etc/apt/sources.list /etc/apt/sources.list
apt update
