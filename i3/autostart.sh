xrandr --output VGA-1 --auto --right-of LVDS-1
numlockx &
telegram-desktop -startintray &
xxkb &
# sbxkb &
~/.fehbg
xinput --set-prop "A4TECH USB Device" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 2
xfce4-power-manager
xautolock -locker "systemctl poweroff" -time 60 &
