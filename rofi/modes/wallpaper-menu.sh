#!/usr/bin/env bash

MATUGEN_TYPE="scheme-rainbow"
RESIZE_FILTER="catmull-rom"

WALL_DIR="$HOME/.config/wallpapers"
CACHE_DIR="$HOME/.config/cache"
THUMB_DIR="$CACHE_DIR/thumbnails"
ROFI_BG="$CACHE_DIR/rofi_bg.png"
HYPRLOCK_BG="$CACHE_DIR/hyprlock_bg.png"

# Ensure directories exist
mkdir -p "$THUMB_DIR"
mkdir -p "$CACHE_DIR"

if [ -z "$1" ] #--------- First call -------------
then
    # 1. Gather all files into an array safely to avoid subshell loop bugs
    mapfile -t IM_LIST < <(find -L "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))
    
    # --- CLEANUP ORPHANED THUMBNAILS ---
    # Create an associative array of valid thumbnail filenames for O(1) lookups
    declare -A VALID_THUMBS
    for image_path in "${IM_LIST[@]}"; do
        filename=$(basename "$image_path")
        VALID_THUMBS["${filename%.*}.png"]=1
    done

    # Loop through existing thumbnails and remove the ones that aren't valid anymore
    if [ -d "$THUMB_DIR" ]; then
        for thumb_path in "$THUMB_DIR"/*.png; do
            # Check if the glob actually found files
            [[ -e "$thumb_path" ]] || break
            
            thumb_name=$(basename "$thumb_path")
            if [[ -z "${VALID_THUMBS[$thumb_name]}" ]]; then
                rm "$thumb_path"
            fi
        done
    fi
    # ------------------------------------

    # 2. Generate the thumbs in a separate "thread"
    gen_thumbs() {
        # "$@" cleanly grabs all arguments passed to this function
        for image_path in "$@"; do
            filename=$(basename "$image_path")
            thumb_path="$THUMB_DIR/${filename%.*}.png"

            if [[ ! -f "$thumb_path" ]]; then
                # This runs ONE at a time, sequentially
                magick "$image_path" -gravity Center -extent 1:1 -thumbnail 400x400 "$thumb_path"
            fi
        done
    }
    gen_thumbs "${IM_LIST[@]}" &
 
    # 3. Print to rofi
    for image_path in "${IM_LIST[@]}"; do
        filename=$(basename "$image_path")
        thumb_path="$THUMB_DIR/${filename%.*}.png"
        echo -en "$filename\0icon\x1f$thumb_path\n"
    done 
else #--------- Second call -------------
    # Strip trailing carriage returns or weird formatting Rofi might pass
    SELECTED_NAME=$(echo "$1" | xargs)
    FULL_PATH="$WALL_DIR/$SELECTED_NAME"

    # Make sure the file actually exists before running operations
    if [[ -f "$FULL_PATH" ]]; then
        # 1. Call matugen to generate color scheme
        (matugen image "$FULL_PATH" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER")&

        # 2. Create a miniature background for the NEXT time Rofi opens
        (magick "$FULL_PATH" \
            -resize 800x450^ \
            -gravity center \
            -crop 800x450+0+0 \
            -blur 0x12 \
            -fill black -colorize 20% \
            "$ROFI_BG")&

        # 3. Create a blurred version to use as hyprlock bg
        (magick "$FULL_PATH" \
            -fill black -colorize 20% \
            "$HYPRLOCK_BG")&
    fi
fi
