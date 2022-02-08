# https://unix.stackexchange.com/questions/253489/how-to-set-the-keymap-for-keyboards-that-are-plugged-in-later 

{ echo "XIDeviceEnabled XISlaveKeyboard"; inputplug -d -c /bin/echo; } |
while read event
do
        case $event in
        XIDeviceEnabled*XISlaveKeyboard*)
                setxkbmap -model pc104 -layout us,ara -option grp:alt_shift_toggle
		;;
        esac
done &

key-mapper-control --command autoload --preset K606 
