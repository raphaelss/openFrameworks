exit_if_not_sudo () {
    if [ "$EUID" != 0 ]; then
        echo this script must be run using sudo
        echo
        echo usage:
        echo sudo "$0"
        exit 1
    fi
}

recompile_poco_if_gcc_gt_4 () {
    export LC_ALL=C
    GCC_MAJOR_GT_4="$(expr `gcc -dumpversion | cut -f1 -d.` \> 4)"
    if [ "$GCC_MAJOR_GT_4" -eq 1 ]; then
        echo
        echo
        echo It seems you are running gcc 5 or later, due to incomatible ABI with previous versions
        echo we need to recompile poco. This will take a while
        read -p 'Press any key to continue... ' -n1 -s

        sys_cores="$(getconf _NPROCESSORS_ONLN)"
        if [ "$sys_cores" -gt 1 ]; then
            cores="$(($sys_cores-1))"
        else
            cores=1
        fi

        DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        cd "${DIR}/../apothecary"
        ./apothecary "-j$cores" update poco
    fi
}
