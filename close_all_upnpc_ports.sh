#!/usr/bin/env bash
# SCRIPT: close_all_upnpc_ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T20:46:39
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

# Check if upnpc is installed
which upnpc &>/dev/null || { echo "Error: Please install 'upnpc' via 'miniupnpc'." >&2; exit 1; }

# Get the list of all redirected ports
port_list=$(upnpc -l | grep  -e 'TCP.*->' | grep -Eo ":[0-9]* " | tr -dc '0-9\n')

if [[ -z "$port_list" ]]; then
    echo "No ports are currently redirected."
    exit 0
fi

# Loop through the ports and delete them
while IFS= read -r port; do
    echo "Closing port $port..."
    upnpc -d $port TCP | grep "Closing"
done <<< "$port_list"

echo "All ports have been processed."
