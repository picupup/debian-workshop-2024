#!/usr/bin/env bash
# SCRIPT: build.sh 
# AUTHOR: primeuser 
# DATE: 2024-11-30T23:35:50
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

echo "services:" > docker-compose.yml

for i in {1..2}; do
	echo -e "  workshop_debian_server_$i:
    image: debian_server_workshop_image
    container_name: \"debian-workshop-$i\"
    restart: unless-stopped
    ports:
      - \"400$i:22\" # Exposes unique ports per instance
      - \"500$i:500$i\"
      - \"600$i:80\"
      - \"700$i:443\"
    environment:
      - USER_NUMBER=$i
    deploy:
      resources:
        limits:
          cpus: \"1.5\"" >> docker-compose.yml
done
