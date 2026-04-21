#!/bin/bash

LOG_DIR="/var/log/server-health"
MAX_LOGS=7

if [ ! -d  "$LOG_DIR" ]; then
	echo "Folder Path Not exist"
	exit 0
fi

log_count=$(ls "$LOG_DIR"/*.log 2>/dev/null | wc -l)



if [ "$log_count" -gt "$MAX_LOGS"]; then
	to_delete=$((log_count - MAX_LOGS))	

	echo "$to_delete Files Will be Delete."

	ls -t "$LOG_DIR"/*.log | tail -n "$to_delete" | while read f; do
		echo "$f will be delete"
		rm "f"
	done
fi

find "$LOG_DIR" -name "*.log" -mtime +1 -exec gzip {} \;
