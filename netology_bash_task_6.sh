#!/bin/bash
RUN_FILE=/tmp/runfile # отслеживаемый файл
S=0.1 # регулярность проверки в секундах

while true; do
    sleep $S
    if [ ! -f "$RUN_FILE" ]; then
        echo "ERROR"
        exit 1
    fi
done