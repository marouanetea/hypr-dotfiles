#!/usr/bin/env bash

# File where your color data is stored (Format: hue,saturation,mode)
echo "called"

COLOR_FILE="$HOME/.config/scripts/color"

if [[ ! -f "$COLOR_FILE" ]]; then
    echo "Error: Color file not found at $COLOR_FILE" >&2
    exit 1
fi

# Read raw string and strip whitespace
COLOR_DATA=$(tr -d '[:space:]' < "$COLOR_FILE")

# Parse the comma-separated values (Hue, Saturation, Mode)
IFS=',' read -r COLOR_HUE COLOR_SAT COLOR_MODE <<< "$COLOR_DATA"

# Validate that Hue and Saturation contain only numbers
if [[ ! "$COLOR_HUE" =~ ^[0-9]+$ ]] || [[ ! "$COLOR_SAT" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid file format. Expected 'hue,saturation,mode' (Got: '$COLOR_DATA')" >&2
    exit 1
fi

# Force lowercase on the mode string just in case
COLOR_MODE="${COLOR_MODE,,}"

# 1. Check for low saturation first (Monochrome / Muted setups)
if (( COLOR_SAT < 20 )); then
    # Match the neutral folder variant to the system background brightness
    if [[ "$COLOR_MODE" == "dark" || "$COLOR_MODE" == "amoled" ]]; then
        BEST_MATCH="white"
    else
        BEST_MATCH="black"
    fi
    echo "Saturation is low (${COLOR_SAT}%) → Snapping to Neutral variant for ${COLOR_MODE} mode: $BEST_MATCH"
else
    # 2. Proceed to Hue matching if color is vibrant enough
    declare -A PAPIRUS_HUES=(
        ["deeporange"]="13"
        ["orange"]="27"
        ["yellow"]="44"
        ["green"]="129"
        ["teal"]="174"
        ["darkcyan"]="180"
        ["cyan"]="190"
        ["blue"]="210"
        ["indigo"]="228"
        ["violet"]="258"
        ["magenta"]="282"
        ["pink"]="331"
        ["red"]="353"
    )

    MIN_DISTANCE=999999
    BEST_MATCH=""

    for color_name in "${!PAPIRUS_HUES[@]}"; do
        preset_hue="${PAPIRUS_HUES[$color_name]}"
        
        # Absolute linear difference
        diff=$(( preset_hue - COLOR_HUE ))
        if (( diff < 0 )); then diff=$(( -diff )); fi
        
        # Handle the 360-degree wrap-around boundary
        if (( diff > 180 )); then
            diff=$(( 360 - diff ))
        fi
        
        distance=$diff
        
        if (( distance < MIN_DISTANCE )); then
            MIN_DISTANCE=$distance
            BEST_MATCH=$color_name
        fi
    done

    echo "Target Hue: ${COLOR_HUE}° (Sat: ${COLOR_SAT}%) → Closest Papirus Match: $BEST_MATCH"
fi

# Apply the theme dynamically
(~/.local/bin/papirus-folders -C "$BEST_MATCH")
echo "done setting colors"

#reload icon theme
CURRENT_ICONS=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
gsettings set org.gnome.desktop.interface icon-theme "$CURRENT_ICONS"
echo "done reloading icon theme"

