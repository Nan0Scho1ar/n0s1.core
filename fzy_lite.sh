#!/bin/sh
# FZY_Lite: 10 SLOC Command Line Fuzzy Finder.
# Copyright: Nan0Scho1ar (Christopher Mackinga) MIT License (29/10/2020)

fzy_lite() {
    str=""; input="$(< /dev/stdin)"; echo -e "\e[?1049h"; while true; do
    filtered=$(echo "$input" | grep ".*$(echo "$str" | sed "s/\(.\)/\1.*/g")");
    echo "$filtered"; read -p "> $str" -n 1 -s < /dev/tty;
    char=$(echo $REPLY | hexdump -c | awk '{ print $2 }');
    [[ $char = "\n" ]] && echo -e "\e[?1049l$filtered" && return 0
    [[ $char = "177" ]] && [[ $str = "" ]] && echo -e "\e[?1049l" && return 1
    [[ $char = "177" ]] && str="${str::-1}" || str="$str$REPLY";
    yes '' | sed "$(tput lines)q"; done
}
