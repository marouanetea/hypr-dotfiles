#!/usr/bin/env bash

MATUGEN_TYPE="scheme-rainbow"
RESIZE_FILTER="catmull-rom"

WALL_DIR="$HOME/.config/wallpapers"
CACHE_DIR="$HOME/.config/cache"
THUMB_DIR="$CACHE_DIR/thumbnails"
ROFI_BG="$CACHE_DIR/rofi_bg.png"
HYPRLOCK_BG="$CACHE_DIR/hyprlock_bg.png"

#1.  Ensure directories exist
mkdir -p "$THUMB_DIR" "$CACHE_DIR"

#2. Gather all files into an array safely
mapfile -t IM_LIST < <(find -L "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

#3. Clean up orphaned thumbs
declare -A VALID_THUMBS
for image_path in "${IM_LIST[@]}"; do
    filename=$(basename "$image_path")
    VALID_THUMBS["$filename.png"]=1
done

#3.1 Loop through existing thumbnails and remove dead ones
if [ -d "$THUMB_DIR" ]; then
    for thumb_path in "$THUMB_DIR"/*.png; do
        [[ -e "$thumb_path" ]] || break
        thumb_name=$(basename "$thumb_path")
        if [[ -z "${VALID_THUMBS[$thumb_name]}" ]]; then
            rm "$thumb_path"
        fi
    done
fi

NEEDS_WAIT=0

#4. Generate missing thumbnails asynchronously
for image_path in "${IM_LIST[@]}"; do
    filename=$(basename "$image_path")
    thumb_path="$THUMB_DIR/$filename.png"

    if [[ ! -f "$thumb_path" ]]; then
        # Process in the background. 
        # Note: If adding hundreds of files at once, consider piping to 'xargs -P' to limit CPU spikes.
        NEEDS_WAIT=1
        magick "$image_path" -gravity Center -extent 1:1 -thumbnail 400x400 "$thumb_path" &
    fi
done

#5. Clean up orphaned jsons
declare -A VALID_JSONS
for image_path in "${IM_LIST[@]}"; do
    filename=$(basename "$image_path")
    VALID_JSONS["$filename.json"]=1
done
#5.1 Loop through existing thumbnails and remove dead ones
if [ -d "$THUMB_DIR" ]; then
    for json_path in "$THUMB_DIR"/*.json; do
        [[ -e "$json_path" ]] || break
        json_name=$(basename "$json_path")
        if [[ -z "${VALID_JSONS[$json_name]}" ]]; then
            rm "$json_path"
        fi
    done
fi

#6. Generate missing color jsons asynchronously
for image_path in "${IM_LIST[@]}"; do
    filename=$(basename "$image_path")
    json_path="$THUMB_DIR/$filename.json"

    if [[ ! -f "$json_path" ]]; then
    	NEEDS_WAIT=1
        (
        	DARK_JSON=$(matugen image "$image_path" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --dry-run --json hex --prefer darkness)
        	LIGH_JSON=$(matugen image "$image_path" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --dry-run --json hex --prefer lightness)
        	SATU_JSON=$(matugen image "$image_path" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --dry-run --json hex --prefer saturation)
        	LSAT_JSON=$(matugen image "$image_path" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --dry-run --json hex --prefer less-saturation)
        	VALU_JSON=$(matugen image "$image_path" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --dry-run --json hex --prefer value)

        	DARK_COL=$(echo "$DARK_JSON" | jq -r ".colors.primary.default.color")
        	LIGH_COL=$(echo "$LIGH_JSON" | jq -r ".colors.primary.default.color")
        	SATU_COL=$(echo "$SATU_JSON" | jq -r ".colors.primary.default.color")
        	LSAT_COL=$(echo "$LSAT_JSON" | jq -r ".colors.primary.default.color")
        	VALU_COL=$(echo "$VALU_JSON" | jq -r ".colors.primary.default.color")

			jq -n \
				--arg dk "$DARK_COL" \
				--arg lg "$LIGH_COL" \
				--arg st "$SATU_COL" \
				--arg ls "$LSAT_COL" \
				--arg vl "$VALU_COL" \
				'{darkness: $dk, lightness: $lg, saturation: $st, less_saturation: $ls, value: $vl}' > "$json_path"
        )&
    fi
done
#wait for all the asynchronous stuff
[[ "$NEEDS_WAIT" -eq 1 ]] && wait


#5. Print to rofi
ROFI_INPUT=""
for image_path in "${IM_LIST[@]}"; do
    filename=$(basename "$image_path")
    thumb_path="$THUMB_DIR/$filename.png"
    ROFI_INPUT+="$filename\0icon\x1f$thumb_path\n"
done

#4. Run rofi
SELECTED_NAME=$(echo -en "$ROFI_INPUT" | rofi -dmenu -config wallpaper.rasi)
FULL_PATH="$WALL_DIR/$SELECTED_NAME"

#5. Get each matugen color with dry runs
if [[ ! -f "$FULL_PATH" ]]; then
	exit 0
fi

JSON_COLOR=$(cat "$THUMB_DIR/$SELECTED_NAME.json")

DARK_COL=$(echo "$JSON_COLOR" | jq -r ".darkness")
LIGH_COL=$(echo "$JSON_COLOR" | jq -r ".lightness")
SATU_COL=$(echo "$JSON_COLOR" | jq -r ".saturation")
LSAT_COL=$(echo "$JSON_COLOR" | jq -r ".less_saturation")
VALU_COL=$(echo "$JSON_COLOR" | jq -r ".value")

COLOR_LIST=""
COLOR_LIST+="<span background=\"$DARK_COL\">       </span>\n"
COLOR_LIST+="<span background=\"$LIGH_COL\">       </span>\n"
COLOR_LIST+="<span background=\"$SATU_COL\">       </span>\n"
COLOR_LIST+="<span background=\"$LSAT_COL\">       </span>\n"
COLOR_LIST+="<span background=\"$VALU_COL\">       </span>\n"



#4. Open the second Rofi window to pick the color
CHOICE=$(echo -en "$COLOR_LIST" | rofi -dmenu -markup-rows -format i -config colorpick.rasi)

if [[ ! -n "$CHOICE" ]]; then
	exit 0
fi
case "$CHOICE" in
	*"0"*) CHOSEN_PREF="darkness"	;;
    *"1"*) CHOSEN_PREF="lightness"	;;
    *"2"*) CHOSEN_PREF="saturation"	;;
	*"3"*) CHOSEN_PREF="less-saturation"	;;
	*"4"*) CHOSEN_PREF="value"	;;
esac

if [[ ! -n "$CHOSEN_PREF" ]]; then
	exit 0
fi
#5. We finally run matugen
(matugen image "$FULL_PATH" -t "$MATUGEN_TYPE" -r "$RESIZE_FILTER" --prefer "$CHOSEN_PREF")&

#6.. Create a miniature background for the NEXT time Rofi opens
#(magick "$FULL_PATH" -resize 800x450^ -gravity center  -crop 800x450+0+0  -blur 0x12  -fill black -colorize 20%  "$ROFI_BG") &
#This was removed and no longer needed due to new rofi relying on true blur on hyprland level

#7. Create a blurred version to use as hyprlock bg
(magick "$FULL_PATH" -fill black -colorize 20%  "$HYPRLOCK_BG") &

#wait for all the asynchronous stuff
wait





