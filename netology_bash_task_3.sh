#!/bin/bash

read -r filename #не изменять

case "$filename" in
    ( *".jpg" | *".gif" | *".png" )
        echo "image"
    ;;
    ( *".mp3" | *".wav" )
        echo "audio"
    ;;
    ( *".txt" | *".doc" )
        echo "text"
    ;;
    *)
        echo "unknown"
    ;;
esac