#!/bin/bash
SCRIPT_DIR=$(dirname "$0")
FILE="${SCRIPT_DIR}/queue#1"
PIDS=`ps cax | grep installdp | grep -o '^[ ]*[0-9]*'`
if [ -z "$PIDS" ]; then
${SCRIPT_DIR}/installdp ${FILE} n
fi
exit $RC