#!/bin/bash

TARGET_URL="https://google.com"
LOGFILE_DIR="/tmp/log"
LOGFILE="$LOGFILE_DIR/networkstatus.log"
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" --max-time 5 $TARGET_URL)
CURRENT_TIME=$(date)

mkdir -p "$LOGFILE_DIR"


if [ "$HTTP_STATUS" -eq "200" ] || [ "$HTTP_STATUS" -eq "301" ] || [ "$HTTP_STATUS" -eq "302" ]; then
	echo "[$CURRENT_TIME] : Connection Success,HTTPS STATUS :  [$HTTP_STATUS]" >> "$LOGFILE"
	exit 0
else
	echo "[$CURRENT_TIME] : Connection Failed,HTTPS STATUS : [$HTTP_STATUS]" >> "$LOGFILE"
	exit 1
fi
