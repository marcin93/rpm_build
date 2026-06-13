#!/usr/bin/bash
# hello-world - simple demo application

CONFIG_FILE="/etc/hello-world/hello-world.conf"

cleanup() {
    echo "End of the application"
    exit 0
}

trap 'cleanup' SIGTERM SIGINT

echo "Application startup"

while true; do
    if [ -f "$CONFIG_FILE" ]; then
        first_line=$(head -n1 "$CONFIG_FILE")
        echo "$first_line"
    else
        echo "Config file not found: $CONFIG_FILE"
    fi
    sleep 10
done
