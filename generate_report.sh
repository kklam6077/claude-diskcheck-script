#!/bin/bash

LOG_DIR="/var/log/server-health"
REPORT="/var/log/server-health/status.html"
DISK_STATUS=$(tail -5 "$LOG_DIR/disk.log" 2>/dev/null || echo "No Disk Data Exist")
NET_STATUS=$(tail -5 "$LOG_DIR/network.log" 2>/dev/null || echo "No Network Data")
GENERATED="$(date '+%Y-%m-%d %H:%M:%S')"
cat > "$REPORT" << EOF
<!DOCTYPE html> 
<html lang="zh-TW"> 
<head>
	<meta charset="UTF-8"> 
	<title> Server Health Status </title> 
	<style> body{font-family:monospace;padding:20px;max-width:800px}
		pre{background:#f5f5f5;padding:12px;border-radius:4px}
		.ok{color:green}
		.warn{color:red}
	</style> 
</head>
<body>
	<h1>Server Health Report </h1>
	<p>Generate Time：$GENERATED</p>
	
	<h2>Disk Status</h2>
	<pre>$DISK_STATUS</pre>

	<h2>Network Status</h2>
	<pre>$NET_STATUS</pre>
</body>
</html>
EOF

echo "Report Generate：$REPORT"
