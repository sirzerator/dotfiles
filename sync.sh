#!/bin/bash
set -euo pipefail
#set -x # Uncomment for debugging

BASENAME=$(basename "$0")
DIRNAME=$(dirname "$0")

TMP_ROOT=$(mktemp -d "/tmp/${BASENAME}.XXXXXX")
trap 'rm -rf $TMP_ROOT' EXIT

echo "Syncing tracked files from home directory to this repository..."

find . -type f ! -path '*.git/*' ! -name README.md ! -name install.sh ! -name sync.sh  -printf '%P\n' > $TMP_ROOT/filelist

for FILE in $(cat $TMP_ROOT/filelist)
do
	echo "Checking $FILE..."
	if diff ~/$FILE $DIRNAME/$FILE > /dev/null 2> /dev/null;
	then
		echo " · No changes"
	else
		echo " → Differs. What should we do?"
		echo
		echo "SOURCE"
		echo '---'
		cat ~/$FILE
		echo
		echo "TARGET"
		echo '---'
		cat $DIRNAME/$FILE
		echo
		echo "diff SOURCE TARGET"
		echo '---'
		diff ~/$FILE $DIRNAME/$FILE || true
		echo "u: Update ; n: Next"
		read -n1 choice
		if [[ $choice == 'u' ]];
		then
			cp ~/$FILE $DIRNAME/$FILE
			echo " ✓ Synced."
		else
			echo " x Skipping."
		fi
	fi
done
