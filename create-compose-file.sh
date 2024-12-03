#!/usr/bin/env bash
# SCRIPT: build.sh 
# AUTHOR: primeuser 
# DATE: 2024-11-30T23:35:50
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

source ports.conf
# Source the environment file to get the limit
source env.conf

# Ensure LIMIT is defined (fallback to 10 if not set)
LIMIT=${LIMIT:-10}

echo "services:" > docker-compose.yml

i=0
array_size=${#ports[@]}

while [ $((i + 1)) -lt $array_size ]; do
    port1=${ports[$i]}
    port2=${ports[$((i + 1))]}
    i=$((i + 2)) # Increment by 2 since we use two ports per service

    echo "Ports $port1 $port2"
    echo -e "  workshop_debian_server_$((i / 2)):
    image: debian_server_workshop_image
    container_name: \"debian-workshop-$((i / 2))\"
    hostname: \"debian-workshop-server-$((i / 2))\"
    restart: unless-stopped
    ports:
      - \"$port1:22\" # Exposes unique ports per instance
      - \"$port2:$port2\"
      - \"$((6000 + i)):80\"
      - \"$((7000 + i)):443\"
    environment:
      - USER_NUMBER=$((i / 2))
    deploy:
      resources:
        limits:
          cpus: \"1.5\"" >> docker-compose.yml

    if [ $((i / 2)) -ge $LIMIT ]; then
        echo "Limit $LIMIT erreicht"
        break
    fi
done

