#!/bin/sh
# TRANSPOSE: Swap columns and rows separated by spaces
# Author: https://stackoverflow.com/users/459745/hai-vu
# Question: https://stackoverflow.com/questions/9534744/how-to-transfer-the-data-of-columns-to-rows-with-awk
# Created: 9/12/2020
# License: MIT License
awk '{ for (i=1; i<=NF; i++) col[i] = col[i] " " $i }
END {
    for (i=1; i<=NF; i++) {
        sub(/^ /, "", col[i]);
        print col[i]
    }
}' file.txt
