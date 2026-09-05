#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 5 September 2026
# Purpose  : Test NomadNet installation

OUT=$(PYTHONUSERBASE=/etc/skel/.local /etc/skel/.local/bin/nomadnet --version)
exit $?
