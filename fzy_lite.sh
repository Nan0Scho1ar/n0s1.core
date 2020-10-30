#!/bin/sh
# FZY_Lite: 10 SLOC Command Line Fuzzy Finder
# Copyright: Nan0Scho1ar (Christopher Mackinga) MIT License (29/10/2020)

fzy_lite() {
    str=""; in="$(< /dev/stdin)"; echo -e "\e[?1049h"; while true; do
    echo "$in" | grep ".*$(echo "$str" | sed "s/\(.\)/\1.*/g")"
    read -p "> $str" -n 1 -s < /dev/tty;
    if [[ $(echo "$REPLY" | od) = $(echo -e "0000000 005177\n0000002\n") ]]; then
    [[ $str = "" ]] && echo -e "\e[?1049l" && return 1 || str="${str::-1}"
    elif [[ $(echo "$REPLY" | od) = $(echo -e "0000000 000012\n0000001\n") ]]; then
    echo -e "\e[?1049l$(echo "$in" | grep ".*$(echo "$str" | sed "s/\(.\)/\1.*/g")")" && return 0
    else str="$str$REPLY"; fi; yes '' | sed "$(tput cols)q"; done;
}
