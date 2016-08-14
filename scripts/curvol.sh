#!/bin/bash

#if ! pacmd list-sink-inputs | grep -q RUNNING
#then exit 0
#fi;
echo -n ""
foo=`amixer -c 0 get Master | grep "Mono:"`
if [[ "$foo" =~ "off" ]];
then echo [m]
else echo $foo | cut -d " " -f4
fi
#echo -n " "

