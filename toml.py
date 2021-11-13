#!/usr/bin/env python3
# toml.py: Read values from a toml file
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: Fri 17 Sep 2021 14:48:03 AEST
# License: GPL v3
# Copyright (C) 2021 Christopher Mackinga <chris@n0s1.net>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

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
