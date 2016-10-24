#!/bin/bash
tmp_file='/tmp/tasks.txt'
script='/home/vdimir/sources/my-toodledo-client/src/task-list.js'

if [ ! -f $tmp_file ] || [ ! `find $tmp_file -mmin -120` ]; then

    while : ; do
        node $script > $tmp_file   
        st=$?
        if [ $(( n++ )) -gt 3 ] || [ $st -eq 0 ]; then
            break
        fi
        sleep 10s
    done
fi

cat $tmp_file
