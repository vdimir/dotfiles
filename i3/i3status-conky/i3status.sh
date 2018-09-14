#!/bin/sh
# a helper script for the conky replacement for i3status

# https://github.com/tonyho/i3wm-conky-config

echo '{"version":1}[[],'
exec conky -c "`dirname \"$0\"`/conkystatus"
