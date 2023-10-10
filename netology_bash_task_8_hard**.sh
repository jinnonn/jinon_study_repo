#!/bin/bash

avgfile() 
{
    DIRNAME=$1
    count=0
    total_size=0
    mid_size=0

    if [[ ! -d $DIRNAME ]]; then
        return 1
    fi

    for file in "$DIRNAME/"*; do
        if [[ -d $file || $(stat -c %F "$file") = "symbolic link" ]]; then
            continue
        else
            ((total_size+=$(stat -c %s "$file")))
            ((count++))
        fi
    done

    mid_size=$(( total_size / count ))

    echo $mid_size
}

avgfile "$1"