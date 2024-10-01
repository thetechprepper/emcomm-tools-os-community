#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 1 October 2024
# Purpose  : Navit installer for EmComm Tools
#
# The Navit package is broken in the Ubuntu repository. The following installation is based
# on a fixed reported in https://github.com/navit-gps/navit/issues/1228

apt install \
  navit \
  navit-gui-gtk \
  navit-graphics-gtk-drawing-area \
  maptool \
  espeak-ng \
  -y 

missing_layout_files=(
  "navit_layout_bike_shipped.xml"
  "navit_layout_car_android_shipped.xml"
  "navit_layout_car_dark_shipped.xml"
  "navit_layout_car_generatedarkxml.sh"
  "navit_layout_car_shipped.xml"
  "navit_layout_car_simple_shipped.xml"
  "navit_layout_th_shipped.xml"
)

echo "Patching broken Navit apt installation..."
TARGET_DIR=/usr/share/navit
for file in "${missing_layout_files[@]}"
do
  curl -s -f -L -O https://raw.githubusercontent.com/navit-gps/navit/trunk/navit/${file}
  mv -v ${file} "${TARGET_DIR}/${file}"
done

# Delete types that have errors
sed -i -e '/item_types="cliff,embankment"/,+7d' ${TARGET_DIR}/navit_layout_car_shipped.xml 

# Copy arizona.bin to ~/.navit/maps
