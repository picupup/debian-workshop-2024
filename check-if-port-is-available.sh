#!/usr/bin/env bash
# SCRIPT: check-if-port-is-available.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T13:11:40
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

file=${1:?"Insert Filename."}
out=${2:-"valid-server.ports"}

f2=$(mktemp)
while read -r port; do
    if ! netstat -tuln | grep -q ":$port "; then
	    echo -ne "\rCheck 1. $port"
	    # Not in use
        echo "$port" >> $f2
    fi
done < $file

while read -r port; do
    if ! ss -tuln | grep -q ":$port "; then
        echo -en "\rCheck 2. $port"
	echo "$port" >> $out
    fi
done < $f2
echo
echo "Saved in '$out'"
rm -f $f2
