if ! command -v exa &> /dev/null
then
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'
else
	alias ls='exa --time-style=long-iso'
	alias ll='ls -alF'
	alias la='ls -a'
	alias lt='ls -T -L2'
	alias lta='ls -T -L2 -a'
	alias ltt='ls -T -L3'
	alias ltta='ls -T -L3 -a'
	alias l='ls -1F'
	alias lm='ls -alF --sort=modified --no-user --no-permissions --no-filesize'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

if command -v bat &> /dev/null
then
	alias cat="bat -p"
fi

if command -v rlwrap &> /dev/null
then
	alias sbcl="rlwrap sbcl"
fi
