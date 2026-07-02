#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 7 May 2026
# Updated : 12 May 2026
# Purpose : Debrand Ubuntu
#
# Post Conditions:
# 1. EmComm Tools splash screen displays on Live USB boot 
# 2. Installer shows EmComm Tools slideshow

et-log "Debranding Ubuntu..."

et-log "Customizing Installer..."
apt install \
  ubiquity-slideshow-ubuntu \
  -y
cp -v -r ../overlay/usr/share/ubiquity-slideshow/* /usr/share/ubiquity-slideshow 

et-log "Customizing boot screen..."
cp -v -r ../overlay/usr/share/plymouth/* /usr/share/plymouth

# A new kernel is required as the initramfs that Cubic uses is
# based on the base ISO by default.
et-log "Installing latest kernel..."
apt install \
  --reinstall \
  linux-headers-generic \
  linux-image-generic \
  -y

# Note: Ensure you select the new kernel on the "Options" screen
# within your Cubic session.
et-log "Rebuilding initramfs..."
update-initramfs -uk all
