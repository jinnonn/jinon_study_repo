#!/bin/bash

while true; do
    timestamp=$(date +%T)
    loadavg1=$(< /proc/loadavg awk '{print $1}')
    loadavg5=$(< /proc/loadavg awk '{print $2}')
    loadavg15=$(< /proc/loadavg awk '{print $3}')
    memfree=$(free | grep Mem | awk '{print $4}')
    memtotal=$(free | grep Mem | awk '{print $2}')
    disktotal=$(df -hT | grep -E /$ | awk '{print $3}')
    diskfree=$(df -hT | grep -E /$ | awk '{print $4}')
    echo "$timestamp $loadavg1 $loadavg5 $loadavg15 $memfree $memtotal $diskfree $disktotal" >> system_info_LOG.txt
    sleep 5
done