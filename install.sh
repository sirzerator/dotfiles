#!/bin/bash
set -euo pipefail
#set -x # Uncomment for debugging

BASENAME=$(basename "$0")
DIRNAME=$(dirname "$0")

TMP_ROOT=$(mktemp -d "/tmp/${BASENAME}.XXXXXX")
trap 'rm -rf $TMP_ROOT' EXIT

echo "Installing files in the home directory"

find . -type f ! -path '*.git/*' ! -name README.md ! -name install.sh ! -name sync.sh  -printf '%P\n' > $TMP_ROOT/filelist

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
		cat ~/$FILE
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

echo "Installing tools..."

if test -f /etc/issue.net && cat /etc/issue.net | grep Debian > /dev/null
then
	sudo apt install build-essential cmake python-is-python3 vim-gtk3
fi

echo " → Rust"

if ! test -d ~/.rbenv
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cargo install du-dust
cargo install bat
cargo install exa

echo " ✓ Done."

echo " → Rbenv"

if ! test -d ~/.rbenv
then
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

echo " ✓ Done."
