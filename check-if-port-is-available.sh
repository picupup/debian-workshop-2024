#!/usr/bin/env bash
# SCRIPT: check-if-port-is-available.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T13:11:40
# REV: 1.0
# PURPOSE: It goes through the input file and checks if the provided ports are currently not used in the server.
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

file=${1:?"Insert Filename."}
out=${2:-"valid-server.ports"}

f2=$(mktemp)
while read -r port; do
    if ! netstat -tuln | grep -q ":$port "; then
	    echo -ne "\r1. Check $port"
	    # Not in use
        echo "$port" >> $f2
    fi
done < $file

while read -r port; do
    if ! ss -tuln | grep -q ":$port "; then
        echo -en "\r2. Check $port"
	echo "$port" >> $out
    fi
done < $f2
echo
echo "Saved in '$out'"
rm -f $f2
