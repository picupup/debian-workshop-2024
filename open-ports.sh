#!/usr/bin/env bash
# SCRIPT: open-ports.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-02T21:48:56
# REV: 1.0
# PURPOSE: Open all ports
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

ports=( 3389 3306 587 5222 990 993 995 27017 5900 25565 )

for i in ${ports[@]}; do 
	./upnpc-map-to.sh "debian workshop" $i
done

