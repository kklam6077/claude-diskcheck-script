#!/bin/bash

LOGFILE="/tmp/disk-alert.log"
MAXLINE=7

if [ ! -f  "$LOGFILE" ]; then
	echo "File Not Exist"
	exit 0
fi

current_lines=$(wc -l < "$LOGFILE")

if [ "$current_lines" -gt "$MAXLINE" ]; then
	echo "Lines is larger than expected"
	tail -n "$MAXLINE" "$LOGFILE" > "${LOGFILE}.tmp" && mv "${LOGFILE}.tmp" "$LOGFILE"
fi
