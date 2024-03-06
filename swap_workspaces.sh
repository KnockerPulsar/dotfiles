#!/bin/bash

# Get the currently focused output
focused_output=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')

# Get the name of the other output
other_output=$(i3-msg -t get_outputs | jq -r --arg focused_output "$focused_output" '.[] | select(.name!=$focused_output and .name!="xroot-0").name')

# Get the workspace names on each output
w1=$(i3-msg -t get_workspaces | jq -r --arg output "$focused_output" '.[] | select(.output==$output and .focused==true).name')
w2=$(i3-msg -t get_workspaces | jq -r --arg output "$other_output" '.[] | select(.output==$output).name')

# Move w1 to the other output and w2 to the focused output
i3-msg "workspace $w1; move workspace to output $other_output"
i3-msg "workspace $w2; move workspace to output $focused_output"
