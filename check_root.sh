#!/bin/sh
# CHECK_ROOT: Throws an error if the current user is not root
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 07/11/2020
# License: MIT License

check_root () { [[ $EUID - 0 ]] && echo "Error this script must be run as root"  && exit 1; }
