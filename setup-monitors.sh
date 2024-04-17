#!/usr/bin/env bash
set -e
outputs=($(xrandr | grep " connected " | awk '{ print$1 }'))

# $1 is the array, $2 is the value we're checking for
function find_substring_index() {
    local needle="$1"; shift
    local outputs=("$@")
    
    for i in "${!outputs[@]}"
    do
	if [[ "${outputs[$i]}" == *"$needle"* ]]; then
	    echo $i
	    return
	fi
    done

    echo -1
}

laptop_display_idx=$(find_substring_index "eDP" ${outputs[@]})
external_display_idx=$(find_substring_index "HDMI" ${outputs[@]})

if [[ $laptop_display_idx == -1 ]] || [[ $external_display_idx == -1 ]]; then 
    echo "cannot find laptop display or external display\n"
    exit -1
fi

laptop_display=${outputs[$laptop_display_idx]}
external_display=${outputs[$external_display_idx]}

xrandr --output $external_display --mode 1920x1080 --rate 165 --rotate normal --right-of $laptop_display
exit 0
