#!/bin/bash

# 1. DYNAMIC DIRECTORY DETECTION
# Resolves the absolute path of the directory containing THIS script,
# regardless of where it was executed from.
DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

# 2. DESTRUCTIVE ACTION WARNING & CONFIRMATION
echo -e "⚠️  WARNING: This script will overwrite specific folders inside your ~/.config/ directory:"
echo "   hypr, kitty, waybar, rofi, matugen, wallpapers, scripts"
echo "Any existing unbacked configurations in those paths will be permanently lost."
echo ""

while true; do
    read -p "Are you sure you want to proceed? (y/N): " response
    case "$response" in
        [Yy]* ) 
            echo -e "\nProceeding with installation...\n"
            break
            ;;
        [Nn]* | "" ) 
            echo -e "\nInstallation aborted by user. No files were modified."
            exit 0
            ;;
        * ) 
            echo "Please answer with 'y' (yes) or 'n' (no)."
            ;;
    esac
done

# Define a function to create symlinks
# Usage: link_config <source_folder> <target_destination>
link_config() {
    local src="$DOTFILES_DIR/$1"
    local dest="$HOME/.config/$1"

    # Check if the destination exists (as a folder, file, or even a broken link)
    if [ -L "$dest" ] || [ -d "$dest" ] || [ -f "$dest" ]; then
        echo "Cleaning up existing path: $dest"
        # We use rm -rf to ensure we remove directories or existing links
        rm -rf "$dest"
    fi

    # Ensure the parent directory (~/.config) exists
    mkdir -p "$(dirname "$dest")"

    # Create the link. 
    # Important: src must be the absolute path to the dotfile folder
    echo "Linking $src -> $dest"
    ln -snf "$src" "$dest"
}

# List the folders you want to link
echo "Starting dotfile symlinking..."

link_config "hypr"
link_config "kitty"
link_config "waybar"
link_config "rofi"
link_config "matugen"
link_config "wallpapers"
link_config "scripts"

echo ""
echo "Done! Your Hyprland environment is now linked."
