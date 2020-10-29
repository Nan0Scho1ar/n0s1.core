#!/bin/sh
# FZY: Command Line Fuzzy Finder
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 29/10/2020
# License: MIT License

fzy() {
    str=""; in="$(< /dev/stdin)";
    backspace=$(echo -e "0000000 005177\n0000002\n")
    enter=$(echo -e "0000000 000012\n0000001\n")
    echo -e "\e[?1049h";
    while true; do
        regex=$(echo "$str" | sed "s/\(.\)/\1.*/g");
        [[ $str = "" ]] && echo "$in" || echo "$in" | grep ".*$regex"
        read -p "> $str" -n 1 -s < /dev/tty;
        if [[ $(echo "$REPLY" | od) = "$backspace" ]]; then
            [[ $str = "" ]] && echo -e "\e[?1049l" && return 1
            str="${str::-1}"
        elif [[ $(echo "$REPLY" | od) = "$enter" ]]; then
            echo -e '\e[?1049l$(echo "$in" | grep ".*$regex")'
            return 0
        else str="$str$REPLY"; fi
        yes '' | sed "$(tput cols)q"
    done
}
