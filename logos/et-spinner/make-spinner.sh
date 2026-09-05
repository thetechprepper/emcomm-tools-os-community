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

SPINNER_PNG="et-32x32-transparent.png"

for i in $(seq 0 35); do
  angle=$((i * 10))
  frame=$(printf "%04d" $((i + 1)))

  convert ${SPINNER_PNG}  \
    -background none \
    -rotate "${angle}" \
    -gravity center \
    -extent 32x32 \
    "animation-${frame}.png"

  # Make a copy for the throbber frame looping animation
  cp "animation-${frame}.png" "throbber-${frame}.png"
done
