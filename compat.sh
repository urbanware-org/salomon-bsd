#!/usr/bin/env bash

#
# Salomon-BSD - Simple log file monitor and analyzer (BSD port)
# Shell compatibility script
# Copyright (C) 2021 by Ralf Kilian
# Distributed under the MIT License (https://opensource.org/licenses/MIT)
#
# GitHub: https://github.com/urbanware-org/salomon-bsd
# GitLab: https://gitlab.com/urbanware-org/salomon-bsd
#

script_dir=$(dirname $(readlink -f $0))
. ${script_dir}/core/shell.sh   # Use POSIX standard instead of 'source' here
shell_precheck_compat

source ${script_dir}/core/common.sh
source ${script_dir}/core/compat.sh
source ${script_dir}/core/global.sh
compatibility_check

echo
echo -e "${cl_lc}Salomon-BSD compatibility check script${cl_n}"

echo
echo -e "Checking operating system kernel .....................$line" \
        "${check_kernel}"
echo -e "Checking Bash shell (version 4 or higher required) ...$line" \
        "${check_bash_major}"
echo
echo -e "Checking capabilities of the 'echo' command ..........$line" \
        "${check_echo}"
echo -e "Checking definition of functions .....................$line" \
        "${check_function}"
echo
echo -e "Checking for 'basename' command ......................$line" \
        "${check_basename}"
echo -e "Checking for 'declare' command (Bash built-in) .......$line" \
        "${check_declare}"
echo -e "Checking for 'dirname' command .......................$line" \
        "${check_dirname}"
echo -e "Checking for 'grep' command ..........................$line" \
        "${check_grep}"
echo -e "Checking for 'paste' command .........................$line" \
        "${check_printf}"
echo -e "Checking for 'printf' command ........................$line" \
        "${check_printf}"
echo -e "Checking for 'readlink' command ......................$line" \
        "${check_readlink}"
echo -e "Checking for 'sed' command ...........................$line" \
        "${check_sed}"
echo -e "Checking for 'tail' command ..........................$line" \
        "${check_tail}"
echo -e "Checking for 'tput' command (part of 'ncurses') ......$line" \
        "${check_tput}"
echo -e "Checking for 'trap' command (Bash built-in) ..........$line" \
        "${check_trap}"
echo
echo -e "Checking for optional 'dialog' command ...............$line" \
        "${check_dialog}"
echo -e "Checking for optional 'less' command .................$line" \
        "${check_less}"
echo -e "Checking for optional 'rsync' command ................$line" \
        "${check_rsync}"
echo -e "Checking for optional 'wget' command .................$line" \
        "${check_wget}"
echo -e "Checking for optional 'whiptail' command .............$line" \
        "${check_whiptail}"
echo
echo -e "Overall status .......................................$line" \
        "${check_overall}"
echo

if [[ $kernel_name =~ linux ]]; then
    echo -e "This seems to be a ${cl_yl}Linux${cl_n} derivate. In this case" \
            "you may use ${cl_yl}Salomon${cl_n} instead of"
    echo -e "${cl_yl}Salomon-BSD${cl_n}."
    echo
fi

exit $return_code

# EOF
