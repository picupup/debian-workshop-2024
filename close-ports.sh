#!/usr/bin/env bash
# SCRIPT: open-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-02T21:48:56
# REV: 1.0
# PURPOSE: Open all ports
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

# Source the ports configuration file and the env.conf file for the limit
source ports.conf
source env.conf  # Ensure env.conf contains a variable LIMIT, like LIMIT=10

# Print message for closing ports
echo "Closing ports to the internet:"

# Total number of ports
total_ports=${#ports[@]}

# If LIMIT is not defined in env.conf, set it to 10
LIMIT=${LIMIT:-10}

# Calculate the end index for the ports to close (LIMIT * 2)
end_index=$((LIMIT * 2))

# Loop through the first LIMIT * 2 ports and close them
for ((i=0; i<$end_index; i++)); do
    port=${ports[$i]}
    echo "Closing $port..."

    # Close the port
    upnpc -d $port TCP >/dev/null
done
