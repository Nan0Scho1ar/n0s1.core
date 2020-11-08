#!/bin/sh
# BM: Bookmarks
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 17/10/2020
# License: MIT License

add() { read -p "Enter key: " key; read -p "Enter value: " val; echo "$key~|~$val" >> $1; }
delete() { sed -i $(cat -n $1 | fzf --with-nth 2.. | awk '{print $1"d"}') $1; }
readval() { cat "$1" | fzf | sed "s/.*~|~//"; }

mkdir -p ~/.config/bookmarks/;
if [ -z $1 ]; then readval $(ls $HOME/.config/bookmarks/*.bm | fzf);
elif [ "$1" = "add" ]; then add "$HOME/.config/bookmarks/$2.bm";
elif [ "$1" = "delete" ]; then delete "$HOME/.config/bookmarks/$2.bm";
else readval "$HOME/.config/bookmarks/$1.bm";
fi
