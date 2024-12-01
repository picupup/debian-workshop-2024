#!/usr/bin/env bash
# SCRIPT: build-image.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-01T01:35:36
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

name=debian_server_workshop_image 

docker image rm -f $name 

docker build -t $name .
