#!/bin/bash

MUS=$(playerctl metadata --format "{{ artist }} - {{ title }}" 2> /dev/null)
#MPD=$(cat "$HOME/.config/ncmpcpp/current-status")
#MPD_SONG=$(cat "$HOME/.config/ncmpcpp/current-song")
S1=$(echo "$MPD" | sed -n '1p')
if [[ $MUS ]]; then
    echo "  $MUS"
elif [ "$S1" == 'playing' ]; then
    echo "  $MPD_SONG"
else
    echo " ﱙ "
fi
