#!/bin/bash
set -u

cmd=$(ls -1 "$1" | dmenu -l 5 -x 450 -y 300 -w 500 -fn "DejaVu Sans Mono-10" ) || exit
exec "$1/$cmd"

