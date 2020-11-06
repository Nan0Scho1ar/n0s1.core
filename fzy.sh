#!/bin/sh
# FZY: Command Line Fuzzy Finder
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 29/10/2020
# License: MIT License

fzy() {
    str="";
    input="$(< /dev/stdin)";
    height="$(tput lines)"
    error=0
    row=1
    col=1
    echo -e "\e[?1049h";
    while true; do
        regex=$(echo "$str" | sed "s/\(.\)/\1.*/g");
        regex2=$(echo "$str" | sed "s/\(.\)/\1|/g");
        range="$row,$((row+height-2))p;$((row+height-2))q"
        filtered=$(echo "$input" | grep ".*$regex" | sed -n $range);
        echo "$filtered" | cut -c$col- | grep -E --color=always "$regex2" | tac;
        read -p "> $str" -n 1 -s < /dev/tty && read -sn3 -t 0.001 k1 < /dev/tty;
        REPLY+=$k1
        numlines="$(echo "$filtered" | wc -l)"
        case "$REPLY" in
            '') echo -e "\e[?1049l$" && echo "$filtered" | sed 1q && return 0;;
            #' ') echo space;;
            $'\e[C'|$'\e0C') col=$((col+1));;
            $'\e[D'|$'\e0D') [[ $col -gt 1 ]] && col=$((col-1));;
            $'\e[B'|$'\e0B') [[ $row -gt 1 ]] && row=$((row-1));;
            $'\e[A'|$'\e0A') [[ $row -lt $((numlines+height)) ]] && row=$((row+1));;
            $'\e[1~'|$'\e0H'|$'\e[H') row=1;;
            $'\e[4~'|$'\e0F'|$'\e[F') row=$numlines;;
            *)
                char=$(echo $REPLY | hexdump -c | awk '{ print $2 }');
                if [[ $char = "033" ]]; then echo -e "\e[?1049l$" && return 0
                elif [[ $char = "177" ]]; then
                    [[ $(echo $str | wc -m) -gt 1 ]] && str="${str::-1}"
                else str="$str$REPLY"; fi
                row=1
            ;;
        esac
        yes '' | sed "$(tput lines)q";
    done
    return $error
}
