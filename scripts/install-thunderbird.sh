#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 5 July 2025
# Purpose : Install Thunderbird email client
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh
. ../overlay/opt/emcomm-tools/bin/et-common

et-log "Installing Thunderbird..."

apt install \
  thunderbird \
  -y
