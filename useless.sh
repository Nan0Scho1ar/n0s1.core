#!/bin/sh
# USELESS: less but less code. Seriously, just use less.
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 30/10/2020
# License: MIT License
# Not very useful in its current form but easily extended

useless() {
    [ -z $1 ] && lines="$(echo "$(< /dev/stdin)")" || lines="$(cat "$1")";
    numlines="$(echo "$lines" | wc -l)" && height="$(tput lines)" && \
    echo -e "\e[?1049h" && b=1 && r="" || return 1
    while true; do
        b2="$((b+height-2))";
        echo "$lines" | sed -n "$b,${b2}p;${b2}q" | grep --colour=always "^\|$r"
        lastline="$([[ $numlines -ge $height ]] && echo $((numlines-height+2)))"
        [[ $b -eq $lastline ]] && cur="$(tput rev)END$(tput sgr0)" || cur=":"
        read -sn1 -p "$cur" < /dev/tty char && echo -e "$(tput el1)\r"
        case $char in
            'q') echo -e "\e[?1049l" && return;;
            'k') [[ $b -gt 1 ]] && b=$((b-1));;
            'j') [[ $b -lt $lastline ]] && b=$((b+1));;
            'g') b=1;;
            'G') b=$lastline;;
            '/') read -p "/" < /dev/tty r
        esac
    done
}
