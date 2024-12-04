#!/usr/bin/env bash
# SCRIPT: update-nftables.sh 
# AUTHOR: ...
# DATE: 2024-12-04T22:51:58
# REV: 1.0
# PURPOSE: In Docker it restarts/starts the nftables and applys the new rulset
# ARGUMENTS: 1: 	2:		3:		4:
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# set -e # Break on the first failure

nft flush ruleset

nft -f /etc/nftables.conf
