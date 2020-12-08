#!/bin/sh
# TOLOWER: Converts all chars in stdin to lowercase
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 8/12/2020
# License: MIT License
tolower() { sed 's/./\L&/g' /dev/stdin; }
