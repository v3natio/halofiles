#!/bin/bash

if nmcli c show --active | grep -q vpn; then
	echo " <span color='#2e3440'>嬨</span> "
else
	echo "   "
fi
