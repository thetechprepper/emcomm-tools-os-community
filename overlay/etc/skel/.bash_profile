# Author      : Gaston Gonzalez
# Date        : 23 April 2024
# Description : bash profile

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
