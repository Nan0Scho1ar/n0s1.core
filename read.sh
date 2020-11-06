#!/bin/sh

while read -sn1 key # 1 char (not delimiter), silent
do
  # catch multi-char special key sequences
  read -sn1 -t 0.0001 k1
  read -sn1 -t 0.0001 k2
  read -sn1 -t 0.0001 k3
  key+=${k1}${k2}${k3}

  case "$key" in
    q) echo q;;
    '') echo return;;
    ' ') echo space;;
    $'\e[?') echo bashspac;;
    h|$'\e[D'|$'\e0D') echo h;;
    j|$'\e[B'|$'\e0B') echo j;;
    k|$'\e[A'|$'\e0A') echo k;;
    l|$'\e[C'|$'\e0C') echo l;;
    $'\e[1~'|$'\e0H'|$'\e[H') echo home;;
    $'\e[4~'|$'\e0F'|$'\e[F') echo end;;
    $'\?') echo backspace;;
    $'\M') echo return;;
    *) echo "$key" | hexdump -c;;
  esac
done
