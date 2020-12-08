#!/bin/sh
# TOUPPER: Converts all chars in stdin to uppercase
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 8/12/2020
# License: MIT License
toupper() { sed 's/./\U&/g' /dev/stdin; }
