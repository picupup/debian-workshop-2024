#!/usr/bin/env bash
# SCRIPT: build.sh 
# AUTHOR: primeuser 
# DATE: 2024-11-30T23:35:50
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution

if [ "$1" = "-r" ];then
	echo "Rebuilding image/container"
	./delete_containers.sh
	./image-build.sh
fi

./create-compose-file.sh


docker compose up --build -d || exit 1

echo 
echo "Listing the containers:"
docker container ls -a | grep debian-workshop-
