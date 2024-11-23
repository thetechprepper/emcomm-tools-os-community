#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 6 October 2024
# Updated : 1 November 2024
# Purpose : Install EmComm Tools applications

et-log "Installing EmComm Tools applications..."

if [ ! -e $ET_HOME ]; then
  mkdir -v -p $ET_HOME
fi

cp -v -r ../overlay/$ET_HOME/* $ET_HOME

et-log "Setting up permission for shared data access..."
chgrp -v -R $ET_GROUP $ET_HOME/conf/radios.d
chmod -v 775 $ET_HOME/conf/radios.d
chmod -v 664 $ET_HOME/conf/radios.d/*.json

chgrp -v -R $ET_GROUP $ET_HOME/conf/template.d/packet
chmod -v 775 $ET_HOME/conf/template.d/packet
chmod -v 664 $ET_HOME/conf/template.d/packet/*.conf
