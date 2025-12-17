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
	logger -t $(basename $0) "cannot find laptop display or external display"
    exit -1
fi

laptop_display=${outputs[$laptop_display_idx]}
external_display=${outputs[$external_display_idx]}

xrandr --output $external_display --mode 1920x1080 --rate 165 --rotate normal --above $laptop_display
# Work around dead zone at the bottom of the monitor
xrandr --setmonitor foo 1920/530x1057/300+0+0 $external_display

exit 0
