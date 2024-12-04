#!/bin/bash
#set -x # For debugging

if ! pgrep -u $USER ssh-agent > /dev/null; then
	eval $(ssh-agent -s)
fi

# Wait for kwallet
kwallet-query -l kdewallet > /dev/null
