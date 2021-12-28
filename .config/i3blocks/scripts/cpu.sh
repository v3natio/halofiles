#!/bin/bash

# mouse actions for the block
case $BLOCK_BUTTON in
	1 | 2 | 3)
        notify-send "  CPU hogs (%)" "$(ps axch -o cmd:10,pcpu k -pcpu | head | awk '$0=$0' )"
        ;;
esac

def_icon1=
def_col=#4c566a
icon1=${1:-$def_icon1}
col=${3:-$def_col}

cpu_perc=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%.2f%\n", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')

echo " <span color='$col'>$icon1</span> $cpu_perc "