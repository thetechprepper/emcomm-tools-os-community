#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 5 September 2026
# Purpose : Generate 36 PNG images for use as a spinner for Plymouth
#
# throbber-xxxx.png is the looping animation on startup
# animation-xxxx.png is the end frame animation
#
# For simplicity, 36 frames are generated for both using ImageMagick.

SIZE=64x64
SPINNER_PNG="et-${SIZE}-icon.png"

convert ../../overlay/usr/share/icons/emcomm-tools-icon-black-512.png \
  -transparent black et-512x512-icon.png

convert et-512x512-icon.png \
  -resize ${SIZE} ${SPINNER_PNG}

for i in $(seq 0 35); do
  angle=$((i * 10))
  frame=$(printf "%04d" $((i + 1)))

  convert ${SPINNER_PNG}  \
    -background none \
    -rotate "${angle}" \
    -gravity center \
    -extent ${SIZE} \
    "animation-${frame}.png"

  # Make a copy for the throbber frame looping animation
  cp "animation-${frame}.png" "throbber-${frame}.png"
done
