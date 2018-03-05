#!/bin/bash

if pacmd list profile | grep -q "active profile: <output:hdmi";
then
    pacmd set-card-profile 0 "output:analog-stereo"
else
    pacmd set-card-profile 0 "output:hdmi-stereo"
fi
