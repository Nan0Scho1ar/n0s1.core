#!/bin/sh
# TOML: Simple get/set commands to read and write toml files
# (Not all featues supported)
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 27/10/2020
# License: MIT License

exprq() { expr "$1" : "$2" 1>/dev/null; }

toml() {
    cmd="$1"
    [ -z $2 ] && lines="$(echo "$(< /dev/stdin)")" || lines="$(cat "$2")";
    parent="$(echo $3 | sed 's/\(.*\)\.\(.*\)/\1/')"
    key="$(echo $3 | sed 's/\(.*\)\.\(.*\)/\2/')"
    value="$4"

    if [ $cmd = "get" ]; then
        # TODO support multiline arrays
        #Remove comments; Filter section; Return value
        begin="$(exprq "$parent" "$key" && echo "0" || echo "/^\s*\[$parent\]/")"
        echo "$lines" | sed -n "s/#.*//g;$begin,/^s*\[.*\]/!d;s/^\s*\"*$key\"*\s*=\s*\(.*\)/\1/p"

    #TODO Fix file indenting
    elif [ $cmd = "set" ]; then
    #echo $cmd
    #echo $parent
    #echo $key
    #echo $value
        if exprq "$parent" "$key"; then
            updated=false
            sed -n "/\\[.*\\]/q;p" "$lines" | \
            while read line; do
                if exprq "$line" "$key=.*"; then
                    echo "$key=$value";
                    updated=true;
                    continue;
                fi
                echo $line;
            done
            $updated || echo "$key=$value";
            sed -n "/\\[.*\\]/,/EOF/p" "$lines"
        else
            in_parent=false
            # try to update value for existing header
            cat "$lines" | while read line; do
                exprq "$line" "\\[.*\\]" && in_parent=false;
                # Set in_parent if currently inside correct header
                exprq "$line" "\\[$parent\\]" && in_parent=true;
                if $in_parent; then
                    # Write new value if existing key found
                    if exprq "$line" "$key=.*"; then
                        echo "$key=$value";
                        in_parent=false;
                        continue;
                        # Write new value if existing key not found
                        # before entering next header
                    elif exprq "$line" "\\[.*\\]" && \
                        ! exprq "$line" "\\[$parent\\]"; then
                            echo "$key=$value";
                            in_parent=false;
                    fi
                fi
                echo $line;
            done;
            # If the header doesn't exist add it and the value
            if ! grep -q "\\[$parent\\]" "$lines"; then
                # TODO Recursively look for parent headers not dump
                # at bottom of lines
                echo "[$parent]" >> $lines && echo "$key=$value" >> $lines
                return
            fi
        fi
    fi
}
