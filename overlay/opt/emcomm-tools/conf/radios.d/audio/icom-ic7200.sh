#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 8 December 2025
# Purpose : Audio settings specific to the ICom IC-7200
#
# Preconditions
# 1. Supported audio interface is connected and properly detected
#
# Postconditions
# 1. ALSA settings set on ET audio device

usage() {
  echo "usage: $(basename $0) <ET audio card> <ET device name>"
}

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

AUDIO_CARD=$1
ET_DEVICE_NAME=$2

# Set the PCM to 82. The default of 41 is too low.
et-log "amixer -q -c ${AUDIO_CARD} sset PCM 96%" 
amixer -q -c ${AUDIO_CARD} sset PCM 96%

et-log "Applied amixer settings for audio card ${AUDIO_CARD} on device ${ET_DEVICE_NAME}"
