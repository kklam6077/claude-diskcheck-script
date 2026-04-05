#!/bin/bash 

THRESHOLD=${1:-80}
echo "$THRESHOLD"

LOGFILE="/tmp/disk-alert.log"

df -h | awk 'NR>1{gsub("%","",$5);if ($5+0>THRESH) print$0}' \
THRESH=$THRESHOLD | while read line; do echo "[$(date)] Warning: $line" | tee -a $LOGFILE
done
