#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 9 October 2024
# Purpose : Configure users and groups
set -e

et-log "Adding '${ET_GROUP}' group..."
groupadd -g 1981  ${ET_GROUP} 

et-log "Configuring users..."

cp -r ../overlay/etc/skel /etc/
[ ! -e /etc/skel/Desktop ] && mkdir /etc/skel/Desktop

et-log "Add all users to dialout group..."
cp -v -r ../overlay/etc/adduser.conf /etc/

