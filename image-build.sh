#!/usr/bin/env bash
# SCRIPT: build-image.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-01T01:35:36
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

pass=secrets/root_password

if [ ! -f ${pass} -o -z "$(cat ${pass})" ]; then 
	echo "Bitte stelle sicher dass '${pass}' existert und den root passwort enthält" >&2
	exit 1
fi

name=debian_server_workshop_image 

docker image rm -f $name 

docker build --no-cache --secret id=root_password,src=./${pass} -t $name .
