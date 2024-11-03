#!/bin/bash
# Author   : Gaston Gonzalez
# Date     : 3 November 2024
# Purpose  : Post installation validation script

PATH=.:$PATH

ls test-*.sh | while read test_case; do
  eval ${test_case}
  if [[ $? -eq 0 ]]; then
    printf "%20s %s\n" "${test_case}" "[PASSED]"
  else
    printf "%20s %s\n" "${test_case}" "[FAILED]"
  fi
done
