#!/bin/bash

WS_4=" 直 "
WS_3=" 直 "
WS_2=" 直 "
WS_1=" 直 "
WS_0=" 睊 "
WS_N=" 睊 "

SSID=$(iwgetid -r)
QUALITY=$(iw dev wlp6s0 link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')
SSIG=$(grep "$(iwgetid -m | awk '{ printf "%s", $1 }')" /proc/net/wireless | awk '{ printf "%i\n", int($3 * 100 / 70) }')

SIG=$(echo "$SSIG" | rev | cut -c 2- | rev)

get_bat() {
    case $SIG in
        0 | 1)	echo "$WS_0$QUALITY% " ;;
        2 | 3)	echo "$WS_1$QUALITY% " ;;
        4 | 5) 	echo "$WS_2$QUALITY% " ;;
        6 | 7) 	echo "$WS_3$QUALITY% " ;;
        *)		echo "$WS_4$QUALITY% "
    esac
}

if [[ $SSID ]]; then
    get_bat
else
    echo "$WS_N"
fi
