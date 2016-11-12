#!/bin/bash

WALLPAPERS_FOLDER=/home/emile/.local/share/wallpapers

WALLPAPERS=($(ls $WALLPAPERS_FOLDER -F | grep -v current))
WP_COUNT=$(ls $WALLPAPERS_FOLDER -F | grep -v current | wc -l)

if [[ $1 = "next" ]]; then
	NEXT_INDEX=$(expr $(cat $WALLPAPERS_FOLDER/current) + 1)
	if [ "$NEXT_INDEX" -ge "$WP_COUNT" ]; then
		NEXT_INDEX=0
	fi
	echo $NEXT_INDEX
	feh --bg-scale $WALLPAPERS_FOLDER/${WALLPAPERS[ $NEXT_INDEX ]}
	echo $NEXT_INDEX > $WALLPAPERS_FOLDER/current
else
	CURRENT_INDEX=$(expr $RANDOM % $WP_COUNT)
	echo $CURRENT_INDEX > $WALLPAPERS_FOLDER/current
	feh --bg-scale $WALLPAPERS_FOLDER/${WALLPAPERS[ $CURRENT_INDEX ]}
fi
