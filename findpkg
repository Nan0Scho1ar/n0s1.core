#!/bin/sh
# FINDPKG: Attempts to find a package using available package managers
# Author: Nan0Scho1ar (Christopher Mackinga)
# Created: 17/10/2020
# License: MIT License

findpkg() {
    local found_pkg_mgr=false
    if command -v pacman >/dev/null 2>&1; then
        found_pkg_mgr=true
        echo -e "`tput setaf 2`Searching using pacman ($(command -v pacman))`tput sgr0`"
        sudo pacman -Sy && pacman -Ss $@ && return
        echo "`tput setaf 3`Could not find package using pacman`tput sgr0`"
    else
        echo "`tput setaf 3`Could not find pacman`tput sgr0`"
    fi

    if command -v yay >/dev/null 2>&1; then
        found_pkg_mgr=true
        echo -e "`tput setaf 2`Searching using yay ($(command -v yay))`tput sgr0`"
        yay -Sy && local list=$(yay -Ss $@)
        [[ $list != '' ]] && echo "$list" && return
        echo `tput setaf 3`"Could not find package using yay`tput sgr0`"
    else
        echo `tput setaf 3`"Could not find yay`tput sgr0`"
    fi

    if $found_pkg_mgr; then
        echo "`tput setaf 1`Could not find package using available package managers`tput sgr0`"
    else
        echo "`tput setaf 1`Could not find any valid package managers`tput sgr0`"
    fi
}
