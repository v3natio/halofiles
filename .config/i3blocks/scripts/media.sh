#!/bin/bash

MUS=$(playerctl -p spotify metadata --format "{{ trunc(artist, 18)}} - {{ trunc(title, 15)}}" 2> /dev/null)
MED=$(playerctl -p mpv metadata --format "{{ trunc(title, 33)}}" 2> /dev/null)
if [[ $MUS ]]; then
    echo "  $MUS"
elif [[ $MED ]]; then
    echo "  $MED"
else
    echo " ﱙ "
fi
