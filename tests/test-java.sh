#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 3 November 2024
# Purpose  : Test Java installation

# We need to redirect stderr to stdout otherwise grep will not match.
JAVA_OUT=$(java -version 2>&1 | grep 20.0.1)
exit $?
