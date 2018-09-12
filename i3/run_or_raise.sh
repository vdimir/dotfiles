#!/bin/bash

WID=`xdotool search --classname "$1"`
if [ -z "$WID" ]; then
    $2
else
    i3-msg "[class=$1] focus"
fi

