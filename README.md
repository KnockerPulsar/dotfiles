# Linux Config
My files for linux configuration.

# How to use
Create a symlink to the configuration folder or file you want to use.
**Make sure the path to the file is absolute**
For example `sudo ln -s /home/USER/Linux-Config/i3 .config/i3`

For brightnessctl to work without root, you can either:
1. Be in the video group. You can add yourself to it by doing `sudo usermod -a -G video $USER` and rebooting.
2. Make it a SUID binary by doing `sudo chmod +s path/to/brightnessctl`

# Dependencies/Applications configured here (assuming gnome is availabe)
* i3, and Applications used in the config file:
  * copyq             : clipboard manager
  * feh               : mainly for backgrounds
  * amixer            : volume control 
  * brightnessctl     : brightness control
  * flameshot         : screenshot utility
  * playerctl         : play and pause audio
  * rofication-daemon : notification daemon
  * rofication-gui    : notification center
  * rofication-i3statusblock (roficiation in the blocks folder): blocklet for notification count
  * timetrap          : CLI time tracking apps
  * google-chrome
  * i3status
* i3blocks 
  * Note that blocklets carry their own dependencies. All blocklets were obtained from [vivien/i3blocks-contrib](https://github.com/vivien/i3blocks-contrib). You can check there for each blocklet's dependencies.
  * jq
  * xkb-switch
    * lib-xbkfile-dev
    * libx11-dev
* neovim
* polkit-gnome-authentication-agent-1 [becuase I had some issues with key-mapper launching](https://github.com/NixOS/nixpkgs/issues/18012#issuecomment-606495647)
* rofi

You can go through each config and change out the dependencies for your own programs or remove them altogether. Note that some paths are hardcoded so you will have to change them.

# Included config files
 * i3
   * Default i3 config
   * launching some applications on startup
     * Calls [setup_keyboard_language.sh](i3/setup_keyboard_language.sh) to setup en/ar switching
     * Starts `copyq` 
     * Starts `gsd-xsettings` so that gnome things work properly
     * Starts `feh` to display a random wallpaper from `/usr/share/backgrounds` folder 
   * i3 colors
     * focued, focused_inactive, unfocues colors
   * i3 flags 
     * default border: Set border style and thiccness
     * default floating border: same as above but for floating windows
* i3 blocks (left to right)
   * Split indicator for the currently focused i3 window.
   * Volume %
   * Network SSID and netspeed up and down 
   * RAM usage & total
   * CPU usage and temperature
   * Battery percentage and status
   * Date & time
   * Keyboard layout/language
   * Notification count
   * Free disk space (calculated from $HOME?)
* nvim (might be out of date, check the config)
   * Built in syntax highlighting
   * no line wrapping
   * Relative + absolute line numbers
   * Auto indentation (Useful for python for example)
   * Incremental search
   * nohlsearch: Hightlight only during searching
   * A bunch of plugins
* logind.conf
   * Sets up the power button and lid closing to suspend the OS.
* .bashrc
  * PATH configuration, aliases, and environment variables.
* .profile
  * Other PATH path configurations (for rofi)
* tlp.conf
    * Defines CPU parameters for battery and AC profiles.
  
# i3 keybinds
| Shortcut/Event                              | Action                                                                            |
| ------------------------------------------- | --------------------------------------------------------------------------------- |
| XF86AudioMute                               | Mute                                                                              |
| XF86AudioLowerVolume / XF86AudioRaiseVolume | Vol up/down                                                                       |
| XF86MonBrightnessUp / XF86MonBrightnessDown | Brightness up/down                                                                |
| XF86AudioPlay                               | Play/pause                                                                        |
| Super+shift+enter                           | launches chrome                                                                   |
| Super+e                                     | launches nautilus (file mananger)                                                 |
| Super+s                                     | launches gnome settings (pay attention to the flags)                              |
| Super+t                                     | Toggles between tabbed, horizontal split, and vertical split window layout        |
| Super+n                                     | launches rofication-gui.py, a notification center                                 |
| Super+BackSpace                             | Toggles between splitting vertically and horizontally (for the next window)       |
| Super+backslash                             | Run `setup_keyboard_language.sh` (for external keyboard use)                      |
| Super+Escape                                | Run `setxkbmap -option caps:none` to disable capslock (for external keyboard use) |
| PrtScr                                      | Launches flameshot (Screenshot utility)                                           |

# Notes
- I had some issues with GNOME themes not applying on Ubuntu 20.04. I was able to apply them using [LXAppearance](https://wiki.lxde.org/en/LXAppearance)
- You must have i3blocks 1.5 or newer for the temperature block to show the correct temperature. Make sure the `SENSOR_CHIP` parameter in i3block's config matches your CPU.
