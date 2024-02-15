# https://unix.stackexchange.com/questions/253489/how-to-set-the-keymap-for-keyboards-that-are-plugged-in-later 

{ echo "XIDeviceEnabled XISlaveKeyboard"; inputplug -d -c /bin/echo; } |
while read event
do
        case $event in
        XIDeviceEnabled*XISlaveKeyboard*)
                setxkbmap -model pc104 -layout us,ara -option "lv3:ralt_alt,grp:alt_shift_toggle"
		setxkbmap -option caps:none
		;;
        esac
done &

input-remapper-control --command autoload --preset K606-v2
