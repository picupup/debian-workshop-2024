#!/usr/bin/env bash
# SCRIPT: open-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-02T21:48:56
# REV: 1.0
# PURPOSE: Open all ports
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

source ports.conf

echo "Closing ports to the internet:"
i=0
for port in ${ports[@]}; do 
	i=$(( i + 1 ))
        port2=$((5000 + i))
	echo "Closing $port2 and $port..."
	upnpc -d $port TCP >/dev/null
done

