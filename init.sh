#!/usr/bin/env bash
# SCRIPT: init.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-03T11:21:54
# REV: 1.0
# PURPOSE: Opens ports and creates the image and starts the docker containers
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

pass=secrets/root_password
mkdir -p secrets
touch ${pass}

if [ ! -f ${pass} -o -z "$(cat ${pass})" ]; then
        echo "Error: Bitte stelle sicher dass '${pass}' existert und den root passwort enthält" >&2
        exit 1
fi

./open-ports.sh

./build.sh -r
