#!/bin/bash

CPU_THR = 80
MEM_THR = 80
DISK_THR = 80
LOG_FILE = "/var/log/sysmob.log"

touch LOG_FILE

DISK_USAGE = $(df -h / | awk '{ if ($5 != "Use%")  print $5}' | sed 's/%//')
MEM_USAGE = $(free | grep Mem | awk '{print $3/$2 *100}')
CPU_USAGE = $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
PROCS = $(ps aux | wc -l)

alert() {
    echo "$(date) $@" >> "$LOG_FILE"
    echo "$(date) $@" > &2
}