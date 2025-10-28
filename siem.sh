#!/bin/bash
LOG_FILE="/var/log/apache2/access.log"
ALERT_FILE="/var/log/siem_alerts.log"

echo "Starting Apache log monitor..."

tail -n 0 -F "$LOG_FILE" | while read line; do
    if echo "$line" | grep -q -E "union.*select|select.*from|union.*cat|cat.*from|union.*echo"; then
        echo "ALERT: SQL Injection detected"
        IP=$(echo "$line" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
        echo "$(date): SQL Injection - $line" >> "$ALERT_FILE"
    fi

    if echo "$line" | grep -q -E "\.\./"; then
        echo "ALERT: Path Traversal"
        IP=$(echo "$line" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
        echo "$(date): Path Traversal - $line" >> "$ALERT_FILE"
    fi

done
