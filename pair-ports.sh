#!/usr/bin/env bash
# SCRIPT: pair-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T15:30:02
# REV: 1.0
# PURPOSE: This pairs the ports so you can, see which pair belongs to the server
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
#!/bin/bash

# Source the ports.conf file
source ports.conf

# Output file
output_file="doc/paired_ports.txt"

# Initialize line number
line_number=1

# Open the output file for writing
> "$output_file"

# Loop through the ports array in pairs
for ((i=0; i<${#ports[@]}; i+=2)); do
    # Ensure there is a pair, i.e., there is a second port
    if [ $((i+1)) -lt ${#ports[@]} ]; then
        port1=${ports[$i]}
        port2=${ports[$((i+1))]}

        # Write the pair and line number to the output file
        echo "$line_number : $port1 - $port2" >> "$output_file"
        line_number=$((line_number + 1))
    fi
done

echo "Port pairs written to $output_file"

