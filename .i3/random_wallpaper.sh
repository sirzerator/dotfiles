#!/bin/bash

WALLPAPERS_FOLDER=/home/emile/.local/share/wallpapers 

WALLPAPERS=($(ls $WALLPAPERS_FOLDER -F))
WP_COUNT=$(ls $WALLPAPERS_FOLDER -F | wc -l)

feh --bg-scale $WALLPAPERS_FOLDER/${WALLPAPERS[ $RANDOM % $WP_COUNT ]}
