#!/bin/sh
# LESS: The hackable less
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 30/10/2020
# License: MIT License

hackless() {
    [ -z $1 ] && lines="$(echo "$(< /dev/stdin)")" || lines="$(cat "$1")";
    numlines="$(echo "$lines" | wc -l)" && height="$(tput lines)" && \
    echo -e "\e[?1049h" && row=1 && col=1 && regex="" || return 1
    while true; do
        echo "$lines" | sed -n "$row,$((row+height-2))p;$((row+height-2))q" | \
            cut -c$col- | grep --colour=always "^\|$regex";
        lastline="$([[ $numlines -ge $height ]] && echo $((numlines-height+2)))"
        [[ $row -eq $lastline ]] && cur="$(tput rev)END$(tput sgr0)" || cur=":"
        read -rsn1 -p "$cur" < /dev/tty char && echo -e "$(tput el1)\r"
        [[ $char == $(printf "\u1b") ]] && read -rsn2 -p "$cur" < /dev/tty char
        case $char in
            'q') echo -e "\e[?1049l" && return;;
            'k') [[ $row -gt 1 ]] && row=$((row-1));;
            'j') [[ $row -lt $lastline ]] && row=$((row+1));;
            'h') [[ $col -gt 1 ]] && col=$((col-1));;
            'l') col=$((col+1));;
            'g') row=1;;
            'G') row=$lastline;;
            '/') read -p "/" < /dev/tty regex;;
        esac
    done
}
