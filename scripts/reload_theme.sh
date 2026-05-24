#!/usr/bin/env bash


echo "Refreshing environment colors..."

# ---- 1. WAYBAR ----
if pgrep -x "waybar" > /dev/null; then
    echo "  -> Reloading Waybar"
    pkill -SIGUSR2 waybar
fi

# ---- 2. HYPRLAND ----
if pgrep -x "Hyprland" > /dev/null; then
    echo "  -> Reloading Hyprland borders/colors"
    hyprctl reload > /dev/null
fi

# ---- 3. ROFI
pkill -x rofi && echo "  -> Closed active Rofi instances"

# ---- 4. DUNST (Notifications) ----
if pgrep -x "dunst" > /dev/null; then
    echo "  -> Reloading Dunst"
    dunstctl reload
fi

# ---- 5. KITTY (Terminals) ----
if pgrep -x "kitty" > /dev/null; then
    echo "  -> Reloading Kitty terminals"
    pkill -SIGUSR1 kitty
fi

echo "All desktop components updated!"
