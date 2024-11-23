#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 1 October 2024
# Updated  : 4 OCtober 2024
# Purpose  : Navit installer for EmComm Tools
# Category : Maps
#
# The Navit package is broken in the Ubuntu repository. The following installation is based
# on a fixed reported in https://github.com/navit-gps/navit/issues/1228

# navit-gui-internal required for car display
# navit-graphics-gtk-drawing-area required for desktop display

apt install \
  navit \
  navit-gui-gtk \
  navit-graphics-gtk-drawing-area \
  navit-gui-internal \
  libcanberra-gtk-dev \
  maptool \
  espeak \
  osmium-tool \
  -y 
