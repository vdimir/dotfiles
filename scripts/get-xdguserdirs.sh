cat ~/.config/user-dirs.dirs | sed -e "s/XDG_\S*\///g" | sed -e /"\#/d" | sed -e "s/\"//g"
