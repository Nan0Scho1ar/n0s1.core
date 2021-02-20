#!/bin/sh
# HIST: Shell history made easy
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 06/11/2020
# License: MIT License

hist() {
    # !50..55
    if [[ $BISH_COMMAND =~ ^\![0-9]+\.\.[0-9]+$ ]]; then
        START="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\.\([0-9]*\)$/\1/')"
        END="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\.\([0-9]*\)$/\2/')"
        for i in $(eval echo "{$START..$END}"); do
            echo "TODO Exec history cmd #$i"
        done
    # !50.&.55
    elif [[ $BISH_COMMAND =~ ^\![0-9]+\.\&\.[0-9]+$ ]]; then
        START="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\&\.\([0-9]*\)$/\1/')"
        END="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\&\.\([0-9]*\)$/\2/')"
        for i in $(eval echo "{$START..$END}"); do
            echo "TODO Exec history cmd #$i &&"
        done
    # !50.|.55
    elif [[ $BISH_COMMAND =~ ^\![0-9]+\.\|\.[0-9]+$ ]]; then
        START="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\|\.\([0-9]*\)$/\1/')"
        END="$(echo $BISH_COMMAND | sed 's/^\!\([0-9]*\)\.\|\.\([0-9]*\)$/\2/')"
        for i in $(eval echo "{$START..$END}"); do
            echo "TODO Exec history cmd #$i ||"
        done
    else
    #TODO Catch &|& and |||
        eval $BISH_COMMAND;
    fi
}
