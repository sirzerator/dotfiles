#!/bin/bash
set -euo pipefail
#set -x # Uncomment for debugging

BASENAME=$(basename "$0")
DIRNAME=$(dirname "$0")

TMP_ROOT=$(mktemp -d "/tmp/${BASENAME}.XXXXXX")
trap 'rm -rf $TMP_ROOT' EXIT

echo "Installing this repositories file in the home directory"

find . -type f ! -path '*.git*' ! -name README.md ! -name install.sh ! -name sync.sh  -printf '%P\n' > $TMP_ROOT/filelist

for FILE in $(cat $TMP_ROOT/filelist)
do
	echo "Checking $FILE..."
	if diff $DIRNAME/$FILE ~/$FILE > /dev/null 2> /dev/null;
	then
		echo " · Already installed"
	else
		if [[ ! -f ~/$FILE ]]
		then
			mkdir -p $(dirname ~/$FILE)
			cp $DIRNAME/$FILE ~/$FILE
			echo " → Installed."
			continue
		fi

		echo " → Differs. What should we do?"
		echo
		echo "SOURCE"
		echo '---'
		cat $DIRNAME/$FILE
		echo
		echo "TARGET"
		echo '---'

		if [[ -f ~/$FILE ]]
		then
			cat ~/$FILE
		else
			echo "File would be created."
		fi

		echo
		echo "diff SOURCE TARGET"
		echo '---'
		diff $DIRNAME/$FILE ~/$FILE || true
		echo "u: Update ; n: Next"
		read -n1 choice
		if [[ $choice == 'u' ]];
		then
			cp $DIRNAME/$FILE ~/$FILE
			echo " ✓ Installed."
		else
			echo " x Skipping."
		fi
	fi
done
