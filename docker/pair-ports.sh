#!/usr/bin/env bash
# SCRIPT: pair-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T15:30:02
# REV: 1.0
# PURPOSE: This pairs the ports so you can see which pair belongs to the server. It also writes it in the README file
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
#!/bin/bash

# Source the ports.conf file
echo "ports=(" > ports.conf
head -n 100 usable.ports.txt >> ports.conf
echo ")" >>ports.conf

source ports.conf


# Output file
output_file=../paired_ports.txt


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
        echo -e "$line_number\t:\t$port1\t-\t$port2" >> "$output_file"
        line_number=$((line_number + 1))
    fi
done

sed -i "/^#Port>/,/^#Port</ { 
    /^#Port>/!{/^#Port</!d} 
    /^#Port>/r $output_file
}" doc/README.md


echo "Port pairs written to $output_file. And ../README.md"

