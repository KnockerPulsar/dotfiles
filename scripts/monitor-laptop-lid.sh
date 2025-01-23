#!/bin/bash

# Monitors laptop lid status and disables the internal screen on close

# How to use
# Set up a service file like so:
# 
# [Unit]
# Description=Lid State Listener
# After=network.target
# 
# [Service]
# Type=simple
# ExecStart=/home/tarek/dotfiles/scripts/monitor-laptop-lid.sh
# Restart=on-failure
# 
# [Install]
# WantedBy=multi-user.target
#
# Then copy or symlink to this file at `/etc/systemd/user/your-link-name.service`
# Then `systemctl --user daemon-reload`
# Finally, `systemctl --user enable lid-monitor.service`

# Check if dbus-monitor is installed
if ! command -v dbus-monitor &> /dev/null
then
    echo "dbus-monitor could not be found, please install it."
    exit 1
fi

# Function to listen for lid state changes
listen_for_lid_state_changes() {
    dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/freedesktop/UPower',arg0='org.freedesktop.UPower'" 2>/dev/null | while read -r line
    do
        if echo $line | grep -q "LidIsClosed"; then
            read -r line
            if echo $line | grep -q "boolean true"; then
		logger 'lid closed'
		xrandr --output eDP-1 --off
            elif echo $line | grep -q "boolean false"; then
		logger 'lid opened'
		xrandr --output eDP-1 --mode 1920x1080 --rate 144 --left-of HDMI-1-0
            fi
        fi
    done
}

# Listen for lid state changes
listen_for_lid_state_changes

# TODO: Update the script to disable the laptop monitor on lid close only if plugged in.
# 	Laptop battery is dead right now so no need to add it
