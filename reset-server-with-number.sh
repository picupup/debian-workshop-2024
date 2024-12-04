#!/usr/bin/env bash
# SCRIPT: reset-server-with-number.sh 
# AUTHOR: ...
# DATE: 2024-12-05T00:29:14
# REV: 1.0
# PURPOSE: ...
# ARGUMENTS: 1: 	2:		3:		4:
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

number=${1:?'Error: Please insert the server name'}
name=workshop_debian_server_${number}

docker compose stop ${name}
docker compose rm -f ${name}
docker compose up -d --force-recreate ${name}
