#!/bin/bash

TIMESTAMP="[$(date '+%Y-%m-%d')]"
HOSTS=( "8.8.8.8" "1.1.1.1" "google.com" )
LOGFILE_DIR="/var/log/server-health"
NETLOG="$LOGFILE_DIR/network.log"

mkdir -p "$LOGFILE_DIR"

echo "$TIMESTAMP Now Starting network-check" >> "$NETLOG"
for host in "${HOSTS[@]}"; do
	if ping -c 2 -W 3 "$host" &>/dev/null;
		then echo "$TIMESTAMP OK: $host connection normal" >> "$NETLOG"
			else echo "$TIMESTAMP Warning $host Error" >> "$NETLOG" | tee -a
	fi
done	

