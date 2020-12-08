#!/bin/sh
# CATENATE: Prepend/Append data to stdin
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 17/10/2020
# License: MIT License

catenate()  { cat <(echo -n "$1") - <(echo -n "$2"); }
