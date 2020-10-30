#!/bin/sh
# FZY: Command Line Fuzzy Finder
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 29/10/2020
# License: MIT License

fzy() {
    str="";
    input="$(< /dev/stdin)";
    echo -e "\e[?1049h";
    while true; do
        regex=$(echo "$str" | sed "s/\(.\)/\1.*/g");
        filtered=$(echo "$input" | grep ".*$regex");
        echo "$filtered";
        read -p "> $str" -n 1 -s < /dev/tty;
        char=$(echo $REPLY | hexdump -c | awk '{ print $2 }');
        [[ $char = "\n" ]] && echo -e "\e[?1049l$filtered" && return 0
        [[ $char = "177" ]] && [[ $str = "" ]] && echo -e "\e[?1049l" && return 1
        [[ $char = "177" ]] && str="${str::-1}" || str="$str$REPLY";
        yes '' | sed "$(tput cols)q";
    done
}
