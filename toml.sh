#!/bin/sh
# Simple get/set commands to read and write toml files
# Not all featues supported
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 27/10/2020
# License: MIT License

exprq() { expr "$1" : "$2" 1>/dev/null; }

toml() {
    parent="$(echo $3 | sed 's/\(.*\)\.\(.*\)/\1/')"
    key="$(echo $3 | sed 's/\(.*\)\.\(.*\)/\2/')"
    value="$4"

    if [ $1 = "get" ]; then
        #Global
        if exprq "$parent" "$key"; then
            sed -n "/\\[.*\\]/q;p" "$2" | \
            # TODO support multiline arrays
                sed -n "s/^\s*$key=\(.*\)/\1/p"
        # Filter to subheading then get value
        else
            sed -n "/^\s*\[$parent\]/,/\[.*\]/{//!p;}" "$2" | \
                # TODO support multiline arrays
                sed -n "s/^\s*$key=\(.*\)/\1/p"
        fi

    #TODO Fix file indenting
    elif [ $1 = "set" ]; then
        if exprq "$parent" "$key"; then
            updated=false
            sed -n "/\\[.*\\]/q;p" "$2" | \
            while read line; do
                if exprq "$line" "$key=.*"; then
                    echo "$key=$value";
                    updated=true;
                    continue;
                fi
                echo $line;
            done
            $updated || echo "$key=$value";
            sed -n "/\\[.*\\]/,/EOF/p" "$2"
        else
            in_parent=false
            # try to update value for existing header
            cat "$2" | while read line; do
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
            if ! grep -q "\\[$parent\\]" "$2"; then
                # TODO Recursively look for parent headers not dump
                # at bottom of file
                echo "[$parent]" >> $2 && echo "$key=$value" >> $2
                return
            fi
        fi
    fi
}
