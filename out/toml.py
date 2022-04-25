#!/usr/bin/env python3
# toml.py: Read values from a toml file
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: Fri 17 Sep 2021 14:48:03 AEST
# License: GPL v3
# Copyright (C) 2021 Christopher Mackinga <chris@n0s1.net>

import sys
import re

def flatten(lines):
    flat = []
    for line in lines:
        if re.match("^\s*#", line):
            continue
        elif re.match("\s*\[.*\]", line):
            parent = line.replace("[", "").replace("]", "").replace(" ", "").replace("\t", "").replace("\n", "")
        elif re.match("\s*.*=.*", line):
            flat.append(parent + "." + re.sub("^\s*", "", line).replace("\t", "").replace("\n", "").replace(" =", "=").replace("= ", "="))
    return flat

# TODO support multiline arrays
# Returns first match
def get(key):
    flat = flatten(sys.stdin)
    for line in flat:
        if key + "=" in line:
            result = re.sub(".*=", "", line)
            return result[1:-1] if re.match("^\".*\"$", result) else result

def get_headers(key):
    flat = flatten(sys.stdin)
    matches = []
    for line in flat:
        if key == line[:len(key)]:
            matches.append(line)
    return matches


if sys.argv[1] == "get":
    print(get(sys.argv[2]))
elif sys.argv[1] == "get_headers":
    for match in get_headers(sys.argv[2]):
        print(match)
