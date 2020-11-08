#!/bin/sh
# USELESS: less but less code. Seriously, just use less.
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 30/10/2020
# License: MIT License
# 20 line pager. Not very useful in its current form but easily extended

useless() {
    [ -z $1 ] && lines="$(echo "$(< /dev/stdin)")" || lines="$(cat "$1")";
    numlines="$(echo "$lines" | wc -l)" && height="$(tput lines)" && \
    echo -e "\e[?1049h" && row=1 && col=1 && regex="" || return 1
    while true; do
        echo "$lines" | sed -n "$row,$((row+height-2))p;$((row+height-2))q"\
            | cut -c $col- | grep --colour=always "^\|$regex";
        read -rsn1 -p ":" < /dev/tty char && echo -e "$(tput el1)\r"
        case $char in
            'q') echo -e "\e[?1049l" && return;;
            'k') [[ $row -gt 1 ]] && row=$((row-1));;
            'j') [[ $row -lt $numlines ]] && row=$((row+1));;
            'h') [[ $col -gt 1 ]] && col=$((col-1));;
            'l') col=$((col+1));;
            'g') row=1;;
            'G') row=$numlines;;
            '/') read -p "/" < /dev/tty regex;;
        esac
    done
}
