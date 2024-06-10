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

if ! test -d ~/.rustup
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	. "$HOME/.cargo/env"
fi

cargo install du-dust
cargo install bat
cargo install eza

echo " ✓ Done."

echo " → Go"

sudo apt install golang
go install github.com/posener/complete/gocomplete@latest

echo " ✓ Done."

echo " → Rbenv"

if ! test -d ~/.rbenv
then
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

echo " ✓ Done."

echo " → PHP"

if ! command -v php > /dev/null
then
	sudo apt-get update
	sudo apt-get -y install lsb-release ca-certificates curl
	sudo curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
	sudo dpkg -i /tmp/debsuryorg-archive-keyring.deb
	sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
	sudo rm /tmp/debsuryorg-archive-keyring.deb
	sudo apt-get update
	sudo apt install php-cli
fi

echo " ✓ Done."

echo " → Composer"

if ! command -v composer > /dev/null
then
	php -r "copy('https://getcomposer.org/installer', '$TMP_ROOT/composer-setup.php');"
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

if [ ! -s "$HOME/.nvm/nvm.sh" ]
then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install v20


echo " ✓ Done."

echo " → Dotnet"

if ! command -v dotnet > /dev/null
then
	wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O $TMP_ROOT/packages-microsoft-prod.deb
	sudo dpkg -i $TMP_ROOT/packages-microsoft-prod.deb
	rm $TMP_ROOT/packages-microsoft-prod.deb
fi

sudo apt-get update && sudo apt-get install -y dotnet-sdk-8.0

echo " ✓ Done."
