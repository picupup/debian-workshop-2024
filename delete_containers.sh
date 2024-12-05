#!/usr/bin/env bash
# SCRIPT: delete_container.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-01T01:29:59
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
docker compose down
docker compose rm -f 
docker container rm -f $( docker container ls -a | grep debian-workshop- | cut -d " " -f 1 ) 2>/dev/null
