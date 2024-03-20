#!/bin/bash
#
# Author  : Gaston Gonzalez
# Date    : 16 March 2024
# Purpose : Install boot screen branding

et-log "Installing EmComm Tools branding"

apt install plymouth-themes -y

PLYMOUTH_DIR=/usr/share/plymouth
BOOT_LOGO=/usr/share/plymouth/ubuntu-logo.png
BOOT_LOGO_ORIG=$BOOT_LOGO.orig

if [ ! -e $BOOT_LOGO_ORIG ]; then
  cp $BOOT_LOGO $BOOT_LOGO_ORIG
  et-log "Backing up boot screen logo: $BOOT_LOGO"
fi

et-log "Installing boot screen logo"
cp ../logos/emcomm-tools-logo-white.png $BOOT_LOGO

et-log "Installing desktop wallpaper"
cp ../logos/emcomm-tools-wallpaper.png /usr/share/backgrounds/
cp ../logos/emcomm-tools-wallpaper.png /usr/share/backgrounds/warty-final-ubuntu.png

gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/emcomm-tools-wallpaper.png
