#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Updated : 6 September 2026
# Purpose : Install boot/installer branding

et-log "Installing EmComm Tools branding"

apt install plymouth-themes -y

PLYMOUTH_DIR=/usr/share/plymouth
UBIQUITY_DIR=/usr/share/ubiquity
BOOT_LOGO=/usr/share/plymouth/ubuntu-logo.png
BOOT_LOGO_ORIG=$BOOT_LOGO.orig

et-log "Installing boot screen logo"
cp -v ../logos/emcomm-tools-logo-white.png $BOOT_LOGO

et-log "Installing desktop wallpaper..."
cp -v ../logos/emcomm-tools-wallpaper.png /usr/share/backgrounds/
cp -v ../logos/emcomm-tools-wallpaper.png /usr/share/backgrounds/warty-final-ubuntu.png

et-log "Installing spinners..."
cp -v ../overlay/usr/share/plymouth/themes/spinner/*.png "${PLYMOUTH_DIR}/themes/spinner/"

et-log "Installing installer assets..."
cp -v ../overlay/usr/share/ubiquity/pixmaps/ubuntu_installed.png "${UBIQUITY_DIR}/pixmaps/"

gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/emcomm-tools-wallpaper.png
