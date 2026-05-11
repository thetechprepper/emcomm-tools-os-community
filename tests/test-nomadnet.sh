#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 11 April 2025
# Purpose  : Test NomadNet installation

OUT=$(PYTHONUSERBASE=/etc/skel/.local /etc/skel/.local/bin/nomadnet --version)
exit $?
