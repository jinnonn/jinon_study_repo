#!/bin/bash

logfile=system_info_LOG.txt

tail -n 25 $logfile | awk -f system_info_ANALYSIS_awk.awk $logfile | grep load
tail -n 37 $logfile | awk -f system_info_ANALYSIS_awk.awk $logfile | grep mem
tail -n 61 $logfile | awk -f system_info_ANALYSIS_awk.awk $logfile | grep disk