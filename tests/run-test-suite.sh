#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 3 November 2024
# Updated  : 8 November 2024
# Purpose  : Post installation validation script

PATH=.:$PATH

YELLOW="\033[1;33m"
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${YELLOW}---------------------------------------"
echo "EmComm Tools Post Validation Test Suite"
echo -e "---------------------------------------${NC}"

ls test-*.sh | while read test_case; do
  eval ${test_case}
  if [[ $? -eq 0 ]]; then
    printf "%20s ${GREEN}%s${NC}\n" "${test_case}" "[PASSED]"
  else
    printf "%20s ${RED}%s${NC}\n" "${test_case}" "[FAILED]"
  fi
done
