#!/usr/bin/env bash
# SCRIPT: compile.sh 
# AUTHOR: primeuser 
# DATE: 2024-12-01T22:40:56
# REV: 1.0
# PURPOSE: ...
# set -x # Uncomment to debug
# set -n # Uncomment to check script syntax without execution
# references: https://stackoverflow.com/a/58885711
# 		https://tex.stackexchange.com/a/651717

pandoc debian-workshop.md --listings -H listings-setup.tex -V colorlinks=true \
-V linkcolor=blue \
-V urlcolor=red \
-V toccolor=gray -o /var/www/html/debian/workshop/debian-workshop.pdf

cp debian-workshop.md /var/www/html/debian/workshop/debian-workshop.md
