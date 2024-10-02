#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 1 October 2024
# Updated  : 2 OCtober 2024
# Purpose  : Navit installer for EmComm Tools
# Category : Maps
#
# The Navit package is broken in the Ubuntu repository. The following installation is based
# on a fixed reported in https://github.com/navit-gps/navit/issues/1228

apt install \
  navit \
  navit-gui-gtk \
  navit-graphics-gtk-drawing-area \
  libcanberra-gtk-dev \
  maptool \
  espeak \
  -y 
