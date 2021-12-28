#!/bin/bash

WS_4=" 直 "
WS_3=" 直 "
WS_2=" 直 "
WS_1=" 直 "
WS_0=" 睊 "
WS_N=" 睊 "

SSID=$(iwgetid -r)
SSIG=$(grep "$(iwgetid -m | awk '{ printf "%s", $1 }')" /proc/net/wireless | awk '{ printf "%i\n", int($3 * 100 / 70) }')

SIG=$(echo "$SSIG" | rev | cut -c 2- | rev)

get_bat() {
    case $SIG in
        0 | 1)	echo "$WS_0$SSIG% " ;;
        2 | 3)	echo "$WS_1$SSIG% " ;;
        4 | 5) 	echo "$WS_2$SSIG% " ;;
        6 | 7) 	echo "$WS_3$SSIG% " ;;
        *)      echo "$WS_4$SSIG% "
    esac
}

if [[ $SSID ]]; then
    get_bat
else
    echo "$WS_N"
fi
