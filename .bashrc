export EDITOR=/usr/bin/vim

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# History configuration
HISTCONTROL=ignoreboth # Ignore duplicates and liens starting with a space
shopt -s histappend # Append to the history file, don't overwrite it
HISTSIZE=-1 # Remember everything
HISTFILESIZE=100000 # Only save the last 100 000 lines

# Low on memory? Abort everything
function panic() {
	echo 'LOW ON MEMORY'
	echo '+ ps au --sort -rss | head'
	ps au --sort -rss | head
	BIGGEST_OFFENDER=$(ps au --sort -rss | head -n 2 | tail -n 1 | sed -e 's/  \+/ /g' | cut -d' ' -f 2)
	read -p 'What should I `kill -9` ? ' -i $BIGGEST_OFFENDER -e KILLPID && kill -9 $KILLPID
	echo "kill -9 $KILLPID" >> ~/.bash_history
	return
};

if test "$(LANG="C" vmstat -s -SM | grep free | sed -e 's/^[[:space:]]*//' | cut -d' ' -f 1 | paste -s -d+ - | bc)" -lt 500
then
	panic
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Apps configuration

# go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# composer
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# wp-cli
source ~/.wp-completion.bash

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# nvm
export NVM_DIR="/home/emile/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pipx
export PATH="$PATH:/home/emile/.local/bin"

function generate_prompt() {
	local last_command_exit_code=$?

	if [ $last_command_exit_code -eq 0 ]; then
		STATUS_PROMPT='\$'
	else
		STATUS_PROMPT=`echo -e "\[\033[1;31m\]($last_command_exit_code)\[\033[0m\] "'\$'""`

	fi

	GIT_PROMPT=$(__git_ps1 "(%s)")
	if [ -n "$GIT_PROMPT" ]; then
		GIT_PROMPT="$GIT_PROMPT "
	fi

	VIM_MODE=${PS1:0:0}
	ACTUAL_PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] [$(date '+%Y-%m-%d %T')]\n $STATUS_PROMPT "
PS1="$VIM_MODE$GIT_PROMPT$ACTUAL_PS1"
}

export PROMPT_COMMAND="generate_prompt"

export VAGRANT_ALIAS_FILE="~/.config/vagrant_aliases"

export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
