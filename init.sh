#!/usr/bin/env bash
# SCRIPT: init.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T11:21:54
# REV: 1.0
# PURPOSE: Opens ports and creates the image and starts the docker containers
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

./open-ports.sh

./build.sh -r
