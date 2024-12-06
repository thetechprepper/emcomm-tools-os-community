#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 4 December 2024
# Purpose  : Test chattervox installation

OUT=$(chattervox -v | grep "0.7.0")
exit $?
