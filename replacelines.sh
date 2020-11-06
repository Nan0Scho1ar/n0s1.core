
        echo "$lines" | sed -n "$b,${b2}p;${b2}q" | grep --colour=always "^\|$r" \
        | while read line; do
            tput cup $row 0
            echo -e "$(tput el)\r$line"
            row=$((row+1))
        done
