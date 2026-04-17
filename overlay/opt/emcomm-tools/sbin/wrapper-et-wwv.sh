#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 April 2026
# Purpose : Wrapper script for setting the system time using et-wwv
#
# Preconditions
# 1. Supported radio and audio interface are connected and properly detected
# 2. Radio is set to AM and a WWV frequency (2.5, 5, 10, 15, or 20 MHz)
#
# Postconditions
# 1. System clock is aligned to the top-of-the-minute
. /opt/emcomm-tools/bin/et-common

exit_if_no_audio

ALSA_DEVICE=$(/opt/emcomm-tools/bin/et-system-info et-audio-card)

et-wwv -a --device "hw:${ALSA_DEVICE}"
