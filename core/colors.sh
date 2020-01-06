#!/usr/local/bin/bash

# ============================================================================
# Salomon-BSD - Simple log file monitor and analyzer (BSD port)
# Color management core script
# Copyright (C) 2019 by Ralf Kilian
# Distributed under the MIT License (https://opensource.org/licenses/MIT)
#
# GitHub: https://github.com/urbanware-org/salomon-bsd
# GitLab: https://gitlab.com/urbanware-org/salomon-bsd
# ============================================================================
declare -A colorize

get_color_code() {
    color_name=$1

    if [ "$color_name" = "none" ] || [ -z "$color_name" ]; then
        color_code="$cl_n"
    elif [[ $color_name =~ ^black ]]; then
        color_code="$cl_bk"
    elif [[ $color_name =~ ^brown ]] || \
         [[ $color_name =~ ^olive ]]; then
        color_code="$cl_br"
    elif [[ $color_name =~ ^darkblue ]] || \
         [[ $color_name =~ ^navy ]]; then
        color_code="$cl_db"
    elif [[ $color_name =~ ^darkcyan ]] || \
         [[ $color_name =~ ^teal ]]; then
        color_code="$cl_dc"
    elif [[ $color_name =~ ^darkgray ]] || \
         [[ $color_name =~ ^gray ]]; then
        color_code="$cl_dy"
    elif [[ $color_name =~ ^darkgreen ]] || \
         [[ $color_name =~ ^green ]]; then
        color_code="$cl_dg"
    elif [[ $color_name =~ ^darkpurple ]] || \
         [[ $color_name =~ ^purple ]]; then
        color_code="$cl_dp"
    elif [[ $color_name =~ ^darkred ]] || \
         [[ $color_name =~ ^maroon ]]; then
        color_code="$cl_dr"
    elif [[ $color_name =~ ^lightblue ]] || \
         [[ $color_name =~ ^blue ]]; then
        color_code="$cl_lb"
    elif [[ $color_name =~ ^lightcyan ]] || \
         [[ $color_name =~ ^aqua ]]; then
        color_code="$cl_lc"
    elif [[ $color_name =~ ^lightgray ]] || \
         [[ $color_name =~ ^silver ]]; then
        color_code="$cl_ly"
    elif [[ $color_name =~ ^lightgreen ]] || \
         [[ $color_name =~ ^lime ]]; then
        color_code="$cl_lg"
    elif [[ $color_name =~ ^lightpurple ]] || \
         [[ $color_name =~ ^fuchsia ]]; then
        color_code="$cl_lp"
    elif [[ $color_name =~ ^lightred ]] || \
         [[ $color_name =~ ^red ]]; then
        color_code="$cl_lr"
    elif [[ $color_name =~ ^white ]]; then
        color_code="$cl_wh"
    elif [[ $color_name =~ ^yellow ]]; then
        color_code="$cl_yl"
    else
        # Support for 256 colors (color code instead of name)
        if [[ $color_name =~ ^random ]]; then
            temp=$(shuf -i ${color_random_min}-${color_random_max} -n 1)
            color_code="\e[38;5;${temp}m"
        else
            re='^[0-9]+'
            if [[ $color_name =~ $re ]]; then
                temp=$(cut -d '-' -f1 <<< $color_name)
                if [ $temp -lt 0 ] || [ $temp -gt 256 ]; then
                    warn "The color '${cl_yl}$color_name${cl_n}' is invalid" 1
                    color_name=""
                    color_code="${cl_n}"
                else
                    color_code="\e[38;5;${temp}m"
                fi
            else
                warn "The color '${cl_yl}$color_name${cl_n}' does not exist" 1
                color_name=""
                color_code="${cl_n}"
            fi
        fi
    fi

    if [[ $color_name =~ \-b\-u$ ]] || [[ $color_name =~ \-u\-b$ ]] || \
       [[ $color_name =~ \-bold\-underlined$ ]] || \
       [[ $color_name =~ \-underlined\-bold$ ]]; then
        temp=$(sed -e "s/\[/\[1;4;/g" <<< $color_code)
        color_code="$temp"
    elif [[ $color_name =~ \-b$ ]] || [[ $color_name =~ \-bold$ ]]; then
        temp=$(sed -e "s/\[/\[1;/g" <<< $color_code)
        color_code="$temp"
    elif [[ $color_name =~ \-u$ ]] || [[ $color_name =~ \-underlined$ ]]; then
        temp=$(sed -e "s/\[/\[4;/g" <<< $color_code)
        color_code="$temp"
    fi
}

get_color_match() {
    color_match=0
    line_input="$1"
    shopt -s nocasematch

    for term in $color_terms; do
        if [[ $line == *"$term"* ]]; then
            color_match=1
            break
        fi
    done

    if [ $color_match -eq 1 ]; then
        get_color_code ${colorize[$term]}
    else
        get_color_code none
    fi
    shopt -u nocasematch
}

print_color_table() {
    echo
    is_tty=$(grep "/tty" <<< $(tty))
    if [ -z "$is_tty" ]; then
        echo "This terminal emulator supports (can display) the following"\
             "colors:"
        echo

        cpl=1
        echo -e "    \c"
        for color in $(jot 255 0); do
            printf "\x1b[48;5;%sm%4d${cl_n}" "$color" "$color";
            cpl=$(( ++cpl ))
            if [ $cpl -gt 16 ] || [ $color -eq 255 ]; then
                cpl=1
                echo -e "\n    \c"
            fi
        done

        echo
        echo "All numbers with black background are colors that cannot be"\
             "displayed (except"
        echo "for number 0). When running Salomon on a pure text-based"\
             "interface (tty) there"
        echo "only are 16 colors available."
    else
        echo "This is a pure text-based interface (tty) which only supports"\
             "(can display)"
        echo "the following 8 or 16 colors (sorted alphabetically):"
        echo
        echo -e "    black, ${cl_br}brown${cl_n}, ${cl_db}darkblue${cl_n},"\
                "${cl_dc}darkcyan${cl_n}, ${cl_dy}darkgray${cl_n},"\
                "${cl_dg}darkgreen${cl_n}," \
                "${cl_dp}darkpurple${cl_n},"
        echo -e "    ${cl_dr}darkred${cl_n}, ${cl_lb}lightblue${cl_n},"\
                "${cl_lc}lightcyan${cl_n}, ${cl_ly}lightgray${cl_n},"\
                "${cl_lg}lightgreen${cl_n}, ${cl_lp}lightpurple${cl_n},"
        echo -e "    ${cl_lr}lightred${cl_n}, ${cl_wh}white${cl_n},"\
                "${cl_yl}yellow${cl_n}"
        echo
        echo "Terminal emulators on a graphical user interface support up" \
             "to 256 colors."
    fi
    echo
}

read_color_file() {
    while read line; do
        if [ -z "$line" ] || [[ $line == *"#"* ]]; then
            continue
        fi
        color_line_code=$(awk '{ print $1 }' <<< "$line")
        color_line_term=$(awk '{ print $2 }' <<< "$line")
        color_temp="$color_terms $color_line_term"
        xargs -n1 <<< "$color_temp" &>/dev/null
        if [ $? -ne 0 ]; then
            warn "Please check the color config for quotes and remove them." 0
            color_terms="$color_temp"
        else
            color_terms=$(xargs -n1 <<< "$color_temp" | sort -u | xargs)
        fi

        colorize+=( ["$color_line_term"]="$color_line_code" )
    done < $color_file
}

# EOF
