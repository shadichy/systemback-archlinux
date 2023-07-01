#!/bin/bash

clear_cache() {
    echo "Clearing cache $([ $1 == 0 ] && echo "before" || echo "after") upgrade..."
    if ! pacman -Scc --noconfirm; then
        echo "Error: failed to clear package cache!"
        exit 1
    fi
    echo "Cache cleared!"
}

update_repo() {
    echo "Updating repositories..."
    if ! pacman -Sy; then
        echo "Error: failed to update repository!"
        exit 1
    fi
    echo "Repositories are up to date!"
}

remove_orphans() {
    echo 'Removing orphan (unneeded) packages'
    unneeded_packages=$(pacman -Qtdq)
    if [ "$unneeded_packages" ] && ! echo "${unneeded_packages}" | pacman -Rns --noconfirm -; then
        echo 'Error: failed to remove orphan (unneeded) packages'
        exit 1
    fi
    echo "Clean!"
}

upgrade_packages() {
    echo "Upgrading packages..."
    if ! pacman -Su --noconfirm; then
        echo "Error: failed to upgrade packages!"
        exit 1
    fi
    echo "All packages are up to date!"
}

fix_broken() {
    echo 'Fixing broken packages'
    broken_packages=$(pacman -Qentk 2>&1)
    if echo "${broken_packages}" | grep -Ev ' 0|warning' && ! echo "${broken_packages}" | grep 'warning' | grep -Ev ' 0|doc|man' | cut -d: -f2 | xargs -n1 | sort -u | pacman -Sdd --noconfirm --overwrite '*' -; then
        echo 'Error: failed to fix broken packages'
        exit 1

    fi
    echo "All packages are good!"
}

clear_cache 0
update_repo || exit 1
remove_orphans || exit 1
upgrade_packages || exit 1
fix_broken || exit 1
clear_cache 1

exit 0
