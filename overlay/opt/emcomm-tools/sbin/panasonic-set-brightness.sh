#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 January 2023
# Updated : 16 March 2024
# Purpose : Fix screen brightness on Panasonic hardware
#
# Note: This fix is based on the following article:
# https://www.bobjohnson.com/bloghow-to-install-ubuntu-on-a-panasonic-toughbook-cf31/

PATH=/opt/emcomm-tools/bin:$PATH

WatchDriver="/sys/class/backlight/panasonic"
PatchDriver="/sys/class/backlight/intel_backlight"

if [ ! -d $WatchDriver ]; then
    et-log  "This is not a Pansonic system. Exiting."
    exit 1
fi

if [ ! -d $PatchDriver ]; then
    et-log "Patch driver directory does not exist: ${PatchDriver}"
    exit 1
fi

# Get maximum brightness values
WatchMax=$(cat $WatchDriver/max_brightness)
PatchMax=$(cat $PatchDriver/max_brightness)

SetBrightness () {
    # Calculate watch current percentage
    WatchAct=$(cat $WatchDriver/actual_brightness)
    WatchPer=$(( WatchAct * 100 / WatchMax ))
    # Reverse engineer patch brightness to set
    PatchAct=$(( PatchMax * WatchPer / 100 ))
    echo $PatchAct | sudo tee $PatchDriver/brightness
}

# When machine boots, set brightness to last saved value
SetBrightness
# Wait forever for user to press Fn keys adjusting brightness up/down.
while (true); do
    /usr/bin/inotifywait --event modify $WatchDriver/actual_brightness
    SetBrightness
done
