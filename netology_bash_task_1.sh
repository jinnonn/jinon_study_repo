#!/bin/bash
#set -xv
read -r DIRNAME # не изменять

if [ -d "$DIRNAME" ]; then
    echo "exists"
else
    mkdir -p "$DIRNAME"
    if [ -d "$DIRNAME" ]; then
        echo "created"
    else
        echo "Something went wrong"
    fi
fi
