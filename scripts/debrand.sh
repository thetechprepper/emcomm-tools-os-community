#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 7 May 2026
# Updated : 11 May 2026
# Purpose : Debrand Ubuntu
#
# Post Conditions:
# 1. Plymouth splash screen displays on Live USB boot 

et-log "Debranding Ubuntu..."

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
