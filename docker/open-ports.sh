#!/usr/bin/env bash
# SCRIPT: open-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-02T21:48:56
# REV: 1.0
# PURPOSE: Open all ports
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e

# Source the environment file to get the limit
source env.conf

echo LIMIT is $LIMIT
# Ensure LIMIT is defined (fallback to 10 if not set)
LIMIT=${LIMIT:?'Limit unset'}

# Source the ports from the ports configuration file
source ports.conf

echo "Opening ports to the internet:"

current_port_list=($(upnpc -l | grep  -e 'TCP.*->' | grep -Eo ":[0-9]* " | tr -dc '0-9\n'))


function port_exists {
	port_to_check=${1}
	for llport in "${current_port_list[@]}"; do
    		if [ "$llport" -eq "$port_to_check" ]; then
        		return 0
        		break
   		fi
	done
	return 1
}

function link-if-not-exists {
	lport="${1}"
	text="$2"

	# Map both ports
    	if ! port_exists "$lport" ; then
		./upnpc-map-to.sh "debian workshop $text" $lport
	else
	       	echo -e "\tPort $lport exists" 
	fi

}


# Total number of ports
total_ports=${#ports[@]}

# Use an index-based for loop to access each port
for ((i = 0; i<LIMIT * 2 && i+1<$total_ports; i += 2)); do

    port=${ports[$i]}
    port2=${ports[$((i + 1))]}  # Select the next port as port2 if available

    if [ -z "$port2" ]; then
        echo "No more paired ports available."
        break
    fi

    servernumber=$(((i / 2) + 1))

    echo "[$servernumber] Opening ports: $port and $port2"

    link-if-not-exists "$port" "debian workshop $servernumber"
    link-if-not-exists "$port2" "debian workshop $servernumber"
done

# If we reach the limit or run out of pairs
if (( i >= total_ports )); then
    echo "No more ports available or reached the limit of $LIMIT"
fi
