#!/bin/bash
set -o nounset -o pipefail
#set -x # For debugging

BASENAME=$(basename "$0")
DIRNAME="$(dirname "$(readlink -f "$0")")"

SCRIPT_FILE=".git/hooks/$BASENAME"
if [ -e "$SCRIPT_FILE" ]; then
	"$SCRIPT_FILE"
else
	exit 0
fi

if [ $? -ne 0 ]; then
	echo "$BASENAME hook error"
	exit 1
else
	exit 0
fi
