#!/usr/bin/env bash

set -euo pipefail

CPU_THR=80
MEM_THR=80
DISK_THR=80
PROC_THR=500
LOG_FILE="/var/log/sysmon.log"

touch "$LOG_FILE"

while true; do
    DISK_USAGE=$(df -h / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
    MEM_USAGE=$(free | awk '/Mem:/ {print int($3/$2 *100)}')
    CPU_USAGE=$(grep 'cpu ' /proc/stat | awk '{print int(($2+$4)*100/($2+$4+$5))}')
    PROCS=$(ps aux | wc -l)

    alert() {
        echo "$(date) $*" >> "$LOG_FILE"
        echo "$(date) $*" >&2
    }

    [ "$DISK_USAGE" -gt "$DISK_THR" ]  && alert "Disk Limit Exceeded: ${DISK_USAGE}% > ${DISK_THR}%"
    [ "$MEM_USAGE"  -gt "$MEM_THR" ]   && alert "Memory Limit Exceeded: ${MEM_USAGE}% > ${MEM_THR}%"
    [ "$CPU_USAGE"  -gt "$CPU_THR" ]   && alert "CPU Usage Limit Exceeded: ${CPU_USAGE}% > ${CPU_THR}%"
    [ "$PROCS"      -gt "$PROC_THR" ]  && alert "Process Count Exceeded: ${PROCS} > ${PROC_THR}"
    sleep 10
done