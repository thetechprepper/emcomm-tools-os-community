#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 16 October 2026
# Purpose  : Test custom Python3 installation

VERSION=3.11
PYTHON="/opt/python/bin/python${VERSION}"

"${PYTHON}" -c "import bz2, ctypes, lzma, readline, sqlite3, ssl, tkinter, zlib"
exit $?
