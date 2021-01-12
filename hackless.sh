#!/bin/sh
# LESS: The hackable less
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 30/10/2020
# License: MIT License

hackless() {
    [ -z $1 ] && lines="$(echo "$(< /dev/stdin)")" || lines="$(cat "$1")";
    row=1 && col=1 && regex="" &&
    height="$(tput lines)" && cols=$(tput cols) &&
    numln="$(echo "$lines" | wc -l)" &&
    maxlen=$(echo "$lines" | awk '{ print length }' | sort -n | tail -1) &&
    lastln="$([[ $numln -ge $height ]] && echo $((numln-height+2)) || echo 1)" &&
    lastcol="$([[ $maxlen -ge $cols ]] && echo $((maxlen-cols+4)) || echo 1)" &&
    lines="$lines$(echo; yes '~' | sed -n "1,${cols}p;${cols}q")" &&
    echo -e "\e[?1049h" || return 1
    while true; do
        #echo -e "'\033[;H'"
        echo "$lines" | sed -n "$row,$((row+height-2))p;$((row+height-2))q" \
            | cut -c $col-$((col+cols-1)) | grep --colour=always "^\|$regex";
        [[ $row -eq $lastln ]] && cur="$(tput rev)END$(tput sgr0)" || cur=":"
        read -rsn1 -p "$cur" < /dev/tty char && echo -e "$(tput el1)\r"
        case $char in
            'q') echo -e "\e[?1049l" && return;;
            'k') [[ $row -gt 1 ]] && row=$((row-1));;
            'j') [[ $row -lt $lastln ]] && row=$((row+1));;
            'h') [[ $col -gt 1 ]] && col=$((col-1));;
            'l') col=$((col+1));;
            'g') row=1;;
            'G') row=$lastln;;
            '0') col=1;;
            '$') col=$lastcol;;
            '/') read -p "/" < /dev/tty regex;;
        esac
    done
}
