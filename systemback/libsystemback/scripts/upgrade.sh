#!/bin/bash

clear_cache() {
    echo "Clearing cache $([ $1 == 0 ] && echo "before" || echo "after") upgrade..."
    pacman -Scc --noconfirm
    if [ $? -ne 0 ]; then
        echo "Error: failed to clear package cache!"
        exit 1
    fi
    echo "Cache cleared!"
}

remove_orphans() {
    echo 'Removing orphan (unneeded) packages'
    unneeded_packages=$(pacman -Qtdq)
    if [ ! -z "$unneeded_packages" ]; then
        echo ${unneeded_packages} | pacman -Rns --noconfirm -
        if [ $? -ne 0 ];then
            echo 'Error: failed to remove orphan (unneeded) packages'
            exit 1
        fi
    fi
    echo "Clean!"
}

fix_broken() {
    echo 'Fixing broken packages'
    broken_packages=$(pacman -Qentk 2>&1)
    if [ ! -z "$(echo ${broken_packages} | grep -Ev ' 0|warning')" ]; then
        echo ${broken_packages} | grep 'warning' | grep -Ev ' 0|doc|man' | cut -d: -f2 | xargs -n1 | sort -u | pacman -Sdd --noconfirm --overwrite '*' -
        if [ $? -ne 0 ];then
            echo 'Error: failed to fix broken packages'
            exit 1
        fi
    fi
    echo "All packages are good!"
}

clear_cache 0
remove_orphans
fix_broken
clear_cache 1

exit 0
