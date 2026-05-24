#!/usr/bin/env bash

lock="${HOME}/.config/rofi/icons/lock.svg"
reboot="${HOME}/.config/rofi/icons/reboot.svg"
shutdown="${HOME}/.config/rofi/icons/shutdown.svg"
suspend="${HOME}/.config/rofi/icons/suspend.svg"


if [ -z "$1" ]; then

    echo -en "Lock\0icon\x1f${lock}\n"
    echo -en "Log off\0icon\x1f${suspend}\n"
    echo -en "Reboot\0icon\x1f${reboot}\n"
    echo -en "Power Off\0icon\x1f${shutdown}\n"
    
else
    case "$1" in
        *"Lock"*)
			hyprctl dispatch "hl.dsp.exec_cmd(\"hyprlock\")" >/dev/null 2>&1
			exit 0
			;;
        *"Power Off"*) 	systemctl poweroff ;;
        *"Reboot"*)    	systemctl reboot ;;
		*"Log off"*) 	hyprctl dispatch "hl.dsp.exit()" ;;
    esac
fi
