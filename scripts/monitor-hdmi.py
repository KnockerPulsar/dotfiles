#!/usr/bin/env python3

import subprocess
import time
import os

def get_hdmi_status():
    try:
        output = subprocess.check_output(['xrandr']).decode('utf-8')
        lines = [line.split()[:2] for line in output.splitlines() if 'HDMI' in line]

        status = {}
        for hdmi, connected in lines:
            status[hdmi] = (connected == "connected")

        return status

    except subprocess.CalledProcessError as e:
        print(f"Error while getting HDMI status: {e}")
        return {}

def setup_monitors():
    try:
        subprocess.check_call(['bash', f"{os.environ['HOME']}/dotfiles/scripts/setup-monitors.sh"])
    except subprocess.CalledProcessError as e:
        print(f"Error while running setup script: {e}")


if __name__ == "__main__":
    status = get_hdmi_status()

    def connected(prev, current):
        return prev is False and current is True

    while True:
        current_status = get_hdmi_status()
    
        if any(connected(status[hdmi], current_status[hdmi]) for hdmi in status):
            status = current_status
            setup_monitors()
        
        time.sleep(1)
