#!/bin/bash

read -r a # не изменять
read -r b # не изменять

if [ "$a" -eq "$b" ]; then
    echo $((a * a))
elif [ "$a" -gt "$b" ]; then
    echo $((a - b))
else
    echo $((b - a))
fi