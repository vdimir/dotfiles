#!/bin/sh

PID_FILE="/tmp/urxvtq.pid"

WID=""

if [ -f $PID_FILE ]; then
        echo "Find"
        PID=`cat $PID_FILE`
        echo $PID
        WID=`xdotool search --all --limit 1 --pid $PID --class urxvt`
fi

if [ -z "$WID" ]; then
        urxvt -e tmux new -A -s main &
        echo $! > $PID_FILE
else
        xdotool windowactivate $WID
fi


