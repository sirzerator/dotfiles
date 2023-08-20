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
		echo "diff $DIRNAME/$FILE ~/$FILE"
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
	sudo apt install build-essential cmake python-is-python3 vim-gtk3 python3-venv python3-virtualenv
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

echo " → Composer"

if ! command -v composer > /dev/null
then
	php -r "copy('https://getcomposer.org/installer', '$TMP_ROOT/composer-setup.php');"
	php -r "if (hash_file('sha384', '$TMP_ROOT/composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('$TMP_ROOT/composer-setup.php'); } echo PHP_EOL;"
	php $TMP_ROOT/composer-setup.php --install-dir=$HOME/.local/bin/ --filename=composer
	chmod +x $HOME/.local/bin/composer
fi

echo " ✓ Done."

echo " → PHPBrew"

if ! command -v composer > /dev/null
then
	curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar > $TMP_ROOT/phpbrew
	mv $TMP_ROOT/phpbrew $HOME/.local/bin/phpbrew
	chmod +x $HOME/.local/bin/phpbrew
fi

echo " ✓ Done."

echo " → Node"

if ! command -v node > /dev/null
then
	curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash
	sudo apt-get install -y nodejs
fi

if ! command -v nvm > /dev/null
then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
	nvm install v20
fi

echo " ✓ Done."
