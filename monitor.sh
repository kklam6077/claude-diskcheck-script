#!/bin/bash 

THRESHOLD=${1:-80}
LOG_DIR="/var/log/server-health"
LOGFILE="$LOG_DIR/disk.log"
mkdir -p "$LOG_DIR"

echo "$THRESHOLD"

df -h | awk 'NR>1{gsub("%","",$5);if ($5+0>THRESH) print$0}' \
THRESH="$THRESHOLD" | while read -r line; do echo "[$(date '+%Y-%m-%d %H:%M:%S')] Warning: $line" | tee -a $LOGFILE
done

bash "$(dirname "$0")/check_network.sh"

bash "$(dirname "$0")/log_rotate.sh"

bash "$(dirname "$0")/generate_report.sh"
