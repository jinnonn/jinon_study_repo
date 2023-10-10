#!/bin/bash

read filename

createfile() 
{
    FILENAME=$1
    if [[ ! -f $FILENAME ]]; then
        touch "$FILENAME" 2> /dev/null
        if [[ -f $FILENAME ]]; then
            return 0
        else
            return 1
        fi
    else
        return 2
    fi
}

createfile "$filename"
