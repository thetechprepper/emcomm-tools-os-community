# Author      : Gaston Gonzalez
# Date        : 23 April 2024
# Updated     : 5 November 2024
# Description : bash profile

# All user accounts should be in the 'et-data' group to allow data sharing with
# EmComm Tools. A umask of 002 is required to allow users and the system to
# read and write shared data files.
umask 002

# Disable the terminal bell for opsec
xset b off

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

RED='\x1B[1;31m'
BLUE='\x1B[1;34m'
CYAN='\x1B[1;36m'
GREEN='\x1B[1;32m'
YELLOW='\x1B[1;33m'
NC='\x1B[0m'

echo -e "${YELLOW}"
cat /etc/motd
echo -e "${NC}"

export ET_USER_CONFIG=${HOME}/.config/emcomm-tools/user.json
export ET_LOG_DIR=${HOME}/.local/share/emcomm-tools

