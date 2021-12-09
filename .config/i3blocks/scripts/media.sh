#!/bin/bash

MUS=$(playerctl -p spotify metadata --format "{{ trunc(artist, 18)}} - {{ trunc(title, 20)}}" 2> /dev/null)
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
