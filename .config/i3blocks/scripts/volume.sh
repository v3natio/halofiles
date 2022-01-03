#!/bin/bash

icon_vol=${1:-}
icon_mute=${2:-}
col=${3:-#fff}

# mouse actions for the block
case $BLOCK_BUTTON in
	1) pamixer -t ;;
    2) st --class wm-floating pulsemixer ;;
    3) st --class wm-floating pulsemixer ;;
	4) pamixer -i 3 ;;
	5) pamixer -d 3 ;;
esac
label=" <span color='$col'>$icon_vol</span>"

#Toggle mute
[[ $(pamixer --get-mute) = "true" ]] && echo "<span color='$col'>$icon_mute</span>  0%" && exit
#Display volume
echo "$label $(pamixer --get-volume-human)";
