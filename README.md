# Linux Config
My files for linux configuration.

# How to use
Create a symlink to the configuration folder or file you want to use.
**Make sure the path to the file is absolute**
For example `sudo ln -s /home/USER/Linux-Config/i3 .config/i3`

For brightnessctl to work without root, you can either:
1. Be in the video group. You can add yourself to it by doing `sudo usermod -a -G video $USER` and rebooting.
2. Make it a SUID binary by doing `sudo chmod +s path/to/brightnessctl`

# Dependencies (assuming gnome is availabe)
* i3
  * netspeed.sh
  * copyq
  * feh
  * amixer
  * brightnessctl
  * google-chrom
  * flameshot
  * inputplug: (I use it to setup layout switching)
  * playerctl: play and pause audio
* i3status
* neovim
* polkit-gnome-authentication-agent-1 [becuase I had some issues with key-mapper launching](https://github.com/NixOS/nixpkgs/issues/18012#issuecomment-606495647)

You can go through each config and change out the dependencies for your own programs or remove them altogether

# Included config files
 * i3
   * Default i3 config
   * launching some applications,
     * Calls setxkvmap to setup en/ar switching
     * Starts copyq 
     * Starts gnome daemon so that gnome things work properly
     * Starts feh to display a random wallpaper from a given folder 
   * keybinds
     * Fn + Mute
     * Fn + Vol up/down
     * Fn + Brightness up/down
     * Super+shift+enter: launches chrome
     * Super+e: launches nautilus (file mananger)
     * Super+s: launches gnome settings (pay attention to the flags)
     * Super+t: Toggles between tabbed, horizontal split, and vertical split window layout
     * Super+BackSpace: Toggles between splitting vertically and horizontally (for the next window)
     * Super+backslash: Run `setup_keyboard_language.sh`
     * PrtScr: Launches flameshot (Screenshot utility
   * i3 colors
     * focues, focused_inactive, unfocues colors
   * i3 flags 
     * focus follows mouse: self explanatory
     * workspace auto back and forth: if you go to work space 2 (super+2), you can press the same buttons again to return to the source workspace
     * default border: Set border style and thiccness
     * default floating border: same as above but for floating windows
* i3status
   * Netspeed up and down (via netspeed.sh)
   * Free disk space (calculated from the root)
   * Battery status and power draw
   * CPU temperature
   * CPU usage
   * RAM usage & total
   * Date & time
* nvim
   * Built in syntax highlighting
   * no line wrapping
   * Relative + absolute line numbers
   * Auto indentation (Useful for python for example)
   * Incremental search
   * nohlsearch: Hightlight only during searching
* logind.conf
   * Sets up the power button and lid closing to suspend the OS.
* .bashrc
  * PATH configuration and aliases
