#!/bin/bash


PRS="`awk '/^# *=+$/,0' $BASH_SOURCE | sed '/^\s*#/d' | sed 's/ //g' `"

for p in $PRS; do
    echo "----- $(gh pr view $p --json title -q '.title') #$p -----" 
    gh pr checks $p
    echo
done

exit 

# ======
23881
29281
