#!/bin/bash
#
# Author   : Gaston Gonzalez
# Date     : 21 November 2022
# Purpose  : Remove unwanted packages

et-log "Removing unwanted packages"

apt purge \
  libreoffice-\* \
  thunderbird \
  snapd \
  unattended-upgrades \
  update-manager \
  update-notifier \
  -y

apt autoremove -y
