#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 2 May 2026
# Purpose : Patch "Copy Fail" vulnerability (CVE-2026-31431).
#
# See https://copy.fail

et-log "Security: Patching Copy Fail vulnerability..."

echo "install algif_aead /bin/false" > /etc/modprobe.d/disable-algif.conf
rmmod algif_aead
