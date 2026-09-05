#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 11 April 2026
# Purpose  : Test Reticulum installation

OUT=$(PYTHONUSERBASE=/etc/skel/.local /etc/skel/.local/bin/rnsd --version)
exit $?
