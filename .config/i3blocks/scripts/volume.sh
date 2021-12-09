#!/bin/bash

LO=" 奔 "
HI=" 墳 "
MO=" 墳 "
MU=" 婢 "

VOL=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
VO=$(echo "$VOL" | cut -d'%' -f1)
V=$(echo "$VO" | rev | cut -c 2- | rev)

get_vol_icon() {
	if [[ $VO -gt 50 ]]; then
		echo "$HI$VOL"
	elif [[ $VO -gt 25 ]]; then
		echo "$MO$VOL"
	else
		echo "$LO$VOL"
	fi
}

if amixer get Master | grep -q '\[on\]'; then
	get_vol_icon
else
	echo "$MU"
fi

