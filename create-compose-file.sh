#!/usr/bin/env bash
# SCRIPT: build.sh 
# AUTHOR: primeuser 
# DATE: 2024-11-30T23:35:50
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

source ports.conf

echo "services:" > docker-compose.yml

i=0
for port in ${ports[@]}; do
	i=$(( i + 1 ))
	port2=$((5000 + i)) 
	echo "Ports $port $port2"
	echo -e "  workshop_debian_server_$i:
    image: debian_server_workshop_image
    container_name: \"debian-workshop-$i\"
    hostname: \"debian-workshop-server-$i\"
    restart: unless-stopped
    ports:
      - \"$port:22\" # Exposes unique ports per instance
      - \"$port2:$port2\"
      - \"$((6000 + i)):80\"
      - \"$((7000 + i)):443\"
    environment:
      - USER_NUMBER=$i
    deploy:
      resources:
        limits:
          cpus: \"1.5\"" >> docker-compose.yml
done
