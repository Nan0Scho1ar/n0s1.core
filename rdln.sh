#!/bin/sh
# RDLN: Read a line from the tty
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 9/12/2020
# License: MIT License

rdln() {
    str="";
    while true; do
        echo -n "> $str"
        char=`rd`
        echo -en "$(tput el1)\r"
        case $char in
            "enter") [[ -z $1 ]] && echo "$str" || eval "$1=\"$str\""; return;;
            "backspace") [[ $(echo $str | wc -m) -gt 1 ]] && str="${str::-1}";;
            *) str+=$char;;
        esac
    done
}
