#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 6 October 2024
# Updated : 5 November 2026
# Purpose : Install EmComm Tools applications
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

et-log "Installing EmComm Tools applications..."

if [ ! -e $ET_HOME ]; then
  mkdir -v -p $ET_HOME
fi

cp -v -r ../overlay/$ET_HOME/* $ET_HOME

et-log "Setting up permission for shared data access..."
chgrp -v -R $ET_GROUP $ET_HOME/conf/radios.d
chmod -v 775 $ET_HOME/conf/radios.d
chmod -v 664 $ET_HOME/conf/radios.d/*.json

chgrp -v -R $ET_GROUP $ET_HOME/conf/radios.d/audio
chmod -v 775 $ET_HOME/conf/radios.d/audio
chmod -v 775 $ET_HOME/conf/radios.d/audio/*.sh

chgrp -v -R $ET_GROUP $ET_HOME/conf/template.d/packet
chmod -v 775 $ET_HOME/conf/template.d/packet
chmod -v 664 $ET_HOME/conf/template.d/packet/*.conf

et-log "Linking man pages only..."
stow -v -d /opt -t /usr/local \
  --ignore='^(bin|conf|sbin)$' \
  emcomm-tools

