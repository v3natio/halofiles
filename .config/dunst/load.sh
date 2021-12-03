#!/bin/bash

pkill dunst
dunst -config ~/.config/dunst/dunstrc &
notify-send -a Notification -u low "Hi !" -i "~/.config/dunst/icons/welcome.svg"
