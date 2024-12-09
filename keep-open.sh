#!/usr/bin/env bash
# SCRIPT: keep-open.sh 
# AUTHOR: ...
# DATE: 2024-12-09T17:11:46
# REV: 1.0
# ARGUMENTS: [1:        ][2:		][3:		][4:        ]
#
# PURPOSE: ...
#
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure


FILE=~/.current.ip
domain="${1:?'Please insert your domain'}"

touch $FILE

# Past IP
PIP=$(cat $FILE)
# Current IP
CIP="$(dig $domain +short)"

if [ -z "$PIP" -o ! "$PIP" = "$CIP" ]; then
	~/repos/debian-workshop-2024/open-ports.sh >/dev/null || exit 1
	echo "[$(date '+%FT%T')] Changed to ${CIP}"
	echo -n "$CIP" > $FILE
# else
	# echo "[$(date '+%FT%T')] All up to date"
fi

