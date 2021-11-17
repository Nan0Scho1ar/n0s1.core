#!/bin/bash
# READ_TOML: One line script to read from a toml file
# Author: Nan0Scho1ar
# Created: 11/1/2021
# License: MIT License
# TODO support multiline values
# TODO support dotted notation (dotted headers/parent already work)
# TODO apologize to my future self or anyone who has to maintin this

sed -n "s/#.*//g;$([[ $1 =~ \. ]] && echo "/^\s*\[`sed 's/\..*//' <<< $1`\]/" || echo 0),/\^\s*[.*\]/!d;s/^\s*\"*`sed 's/.*\.//' <<< $1`\"*\s*=\s*//p" <<< $(cat $2 || cat /dev/stdin)

#Super Minimal version which doesn't strip comments before processing and can't handle malformed whitespace
#cat $2 | sed -n "$([[ $1 =~ \. ]] && echo "/^\[`sed 's/\..*//' <<< $1`\]/" || echo 0),/\^[.*\]/!d;s/^\s*\"*`sed 's/.*\.//' <<< $1`\"*\s=\s//p"

#Explainer
#parent="$(sed 's/\..*//' <<< "$1")"
#key="$(sed 's/.*\.\//' <<< "$1")"
#begin="$([[ $1 =~ \. ]] && echo "/^\s*\[$parent\]/" || echo 0)"
##Remove comments from file; Filter to section; Return value
#sed -n "s/#.*//g;$begin,/^\s*\[.*\]/!d;s/^\s*\"*$key\"*\s*=\s*//p" <<< $(cat $2 || cat /dev/stdin)
