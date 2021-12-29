#!/bin/bash

# mouse actions for the block
case $BLOCK_BUTTON in
	1 | 2 | 3)
        notify-send "  CPU hogs (%)" "$(ps axch -o cmd:10,pcpu k -pcpu | head | awk '$0=$0' )"
        ;;
esac

cpu_perc=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%.2f%\n", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')

echo "  $cpu_perc "
