# Linux Config
My files for linux configuration.

# Dependencies (assuming gnome is availabe)
* i3
  * netspeed.sh
  * copyq
  * feh
  * amixer
  * brightness
  * google-chrom
  * flameshot
* i3status
* neovim

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
     * PrtScr: Launches flameshot (Screenshot utility)
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

