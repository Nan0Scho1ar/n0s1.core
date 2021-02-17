#!/bin/sh
# RD: Read a character from the tty
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 9/12/2020
# License: MIT License

rd() {
    IFS=
    read -rsn1 mode # get 1 character
    [[ $mode == $(printf "\u1b") ]] && read -rsn4 -t 0.001 mode2
    char=$(echo -n "$mode$mode2" | sed 's/\[A//;s/\[B//;s/\[C//;s/\[D//;')
    if [[ "$(echo -n $char | hexdump -c | tr -d '\n' | tr -d ' ')" == '00000000000001' ]]; then
        str='space'
    else
        case "$char" in
            [a-zA-Z0-9,._+:@%/-\#\$\^\&\*\(\)\=\{\}\|\\\;\'\"\<\>\~\`\[\]]) str=$char;;
            '!') str='!';;
            '?') str='?';;
            *)
                seq=$(echo -n "$mode$mode2" | hexdump -c | sed 's/^0+ \(.*\) \\n/\1/;s/ //g;s/^0*//;1q')
                case $seq in
                    '33') str='esc' ;;
                    '33[A') str='up' ;;
                    '33[B') str='down' ;;
                    '33[C') str='right' ;;
                    '33[D') str='left' ;;
                    *)
                        s=$(echo $seq | sed 's/\[A//;s/\[B//;s/\[C//;s/\[D//;')
                        case $s in
                            '') str='enter' ;;
                            '1') str='^A' ;;
                            '177') str='backspace' ;;
                            *) str=$seq ;;
                        esac
                        ;;
                esac
                ;;
        esac
    fi
    [[ -z $1 ]] && echo "$str" || eval "$1=\"$str\""
}
