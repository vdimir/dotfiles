#!/bin/bash

# Originally based on code by Dieter Plaetinck.
# Pretty much re-written by Mina Nagy (mnzaki)

dmenu_cmd="dmenu $DMENU_OPTIONS"
terminal="urxvt -e"
max_recent=199 # Number of recent commands to track

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/dmenu-recent"
recent_cache="$cache_dir/recent"
rest_cache="$cache_dir/all"
known_types=" background terminal terminal_hold "

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/dmenu-recent"
mkdir -p "$cache_dir"
mkdir -p "$config_dir"
touch "$recent_cache"

IFS=:
if stest -dqr -n "$rest_cache" $PATH 2>/dev/null; then
     stest -flx $PATH | sort -u | grep -vf "$recent_cache" > "$rest_cache"
fi

IFS=" "
cmd=$(cat "$recent_cache" "$rest_cache" | $dmenu_cmd "$@") || exit

if ! grep -qx "$cmd" "$recent_cache" &> /dev/null; then
    grep -vx "$cmd" "$rest_cache" > "$rest_cache.$$"
    mv "$rest_cache.$$" "$rest_cache"
fi

echo "$cmd" > "$recent_cache.$$"
grep -vx "$cmd" "$recent_cache" | head -n "$max_recent" >> "$recent_cache.$$"
mv "$recent_cache.$$"  "$recent_cache"

# Figure out how to run the command based on the command name, disregarding
# arguments, if any.
word0=${cmd%% *}
match="^$word0$"
echo "$match"

get_type () {
    while type=$(echo $known_types | xargs -n1 | $dmenu_cmd -p Type:); do
        [[ $known_types =~ " $type " ]] || continue
        echo "$word0" >> "$config_dir/$type"
        break
    done
    echo $type
}

if ! type=$(grep -lx "$match" -R "$config_dir"); then
    type=$(get_type)
else 
    type=${type##*/}
    if ! [[ $known_types =~ " $type " ]]; then
        rm "$config_dir/$type"
        type=$(get_type)
    fi
fi

[[ "$type" = "background" ]] && exec $cmd
[[ "$type" = "terminal" ]] && exec $terminal "$cmd"
[[ "$type" = "terminal_hold" ]] &&
    exec $terminal sh -c "$cmd && echo Press Enter to kill me... && read line"