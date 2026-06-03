#!/usr/bin/env bash

# 1. List of manual apps
WHITELIST=(
    "org.telegram.desktop.desktop"
)

# Dynamically fetch Chrome web apps
mapfile -t WEBAPPS < <(ls "$HOME/.local/share/applications/" 2>/dev/null | grep "^chrome-")

# 2. Function to extract Name and Icon from a desktop file
get_app_info() {
    local file=$1
    local path=""

    # Find where the desktop file lives (system or user local)
    if [ -f "$HOME/.local/share/applications/$file" ]; then
        path="$HOME/.local/share/applications/$file"
    elif [ -f "/usr/share/applications/$file" ]; then
        path="/usr/share/applications/$file"
    else
        return 1 # Return an error status if file isn't found
    fi

    # Extract Name and Icon (taking the first match under [Desktop Entry])
    local name=$(sed -n '/^\[Desktop Entry\]/,/^\[/p' "$path" | grep -m 1 "^Name=" | cut -d'=' -f2)
    local icon=$(sed -n '/^\[Desktop Entry\]/,/^\[/p' "$path" | grep -m 1 "^Icon=" | cut -d'=' -f2)

    # Format for Rofi: Display Name\0icon\x1fIconName\x1finfo\x1fDesktopFileName
    echo -e "${name}\0icon\x1f${icon}\x1finfo\x1f${file}"
    return 0
}

# 3. Rofi script mode logic
if [ -z "$1" ]; then
    echo -e "\0no-custom!true"
    
    # Run through manual whitelist (only printing if the function succeeds)
    for app in "${WHITELIST[@]}"; do
        get_app_info "$app" >/dev/null && get_app_info "$app"
    done
    
    # Run through automated webapps
    for app in "${WEBAPPS[@]}"; do
        get_app_info "$app" >/dev/null && get_app_info "$app"
    done
else
    # ROFI_INFO contains the .desktop filename we passed in the info field
    ( gtk-launch "$ROFI_INFO" > /dev/null 2>&1 )&
    exec true
fi
