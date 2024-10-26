#!/bin/bash
# Author  : Gaston Gonzalez
# Date    : 26 October 2024
# Purpose : Install JS8Call development tools
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'et-log "\"${last_command}\" command failed with exit code $?."' ERR

. ./env.sh

et-log "Installing JS8Call development tools..."

apt install \
  qtbase5-dev \
  qtbase5-dev-tools \
  qt5-qmake \
  qtchooser \
  qtmultimedia5-dev \
  libqt5serialport5-dev \
  libfftw3-dev \
  qttools5-dev-tools \
  -y


cat << 'EOF'

# JS8Call Development Notes

Here are my notes on building JS8Call from source. We are going to modify
this wonderful program with some new features. -- TTP

## Building JS8Call

```
$ mkdir src && cd src
$ git clone https://bitbucket.org/widefido/js8call.git
$ cd js8call
$ mkdir build && cd build
$ cmake ..
$ make
```

## Troubleshooting JS8Call

Start JS8Call with logging.

```
$ ./js8call -o out.log
```

EOF
