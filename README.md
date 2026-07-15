# marouanetea / hypr-dotfiles
A minimalist, local-first, dynamic Wayland desktop environment powered by **Hyprland** and dynamically themed on-the-fly using **Matugen**.

This setup utilizes a custom image processing pipeline that generates material color schemes across all terminal and desktop components instantly upon changing the wallpaper.

---

## Core Dependencies
To ensure everything runs seamlessly, your system will require:

- Window Manager: hyprland, hyprlock
- Theming & Utilities: matugen, awww, papirus-icon-theme
- UI Components: rofi, waybar, swaync, kitty
- Dependencies for Scripts: imagemagick (for thumbnail generation and blurring), jq (for parsing cached Matugen JSON colors).

## Repository Structure

All configuration files live in `~/.dotfiles` and are symlinked into their respective locations in `~/.config`.

```
~/.dotfiles/
├── fastfetch/      # System fetch layout
├── hypr/           # Hyprland & Hyprlock configurations
├── kitty/          # Terminal emulator styles
├── matugen/        # Material color generation templates
├── rofi/           # Application launcher & custom menus
├── scripts/        # Miscellaneous helper scripts
├── swaync/         # Notification center styling
├── wallpapers/     # Wallpaper repository
├── waybar/         # Status bar configuration & styling
└── install.sh      # Setup and symlinking entry point
```

> [!TIP]
> This setup also relies on a few local binaries (like the official papirus-folders shell script) kept in `~/.local/bin` to manage standalone tools outside of package management.

## Installation
> [!WARNING]
> **CRITICAL WARNING:** Running install.sh is destructive. It will completely delete existing configuration directories in your `~/.config` directory before replacing them with symlinks to this repository. Back up your data before proceeding.

To clone and apply the dotfiles:

```Bash
git clone "https://github.com/marouanetea/hypr-dotfiles.git" ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

## Theming Engine & Workflow
The core of this configuration relies on Matugen for system-wide color generation.

```
[ Wallpaper Menu ] ➔ [ Matugen ] ➔ [ Updates System Themes ]
                                 ➔ [ Sets Wallpaper using awww ]
                                 ➔ [ Matches color to Papirus Folders ]
```
## Custom Wallpaper Chooser Pipeline
The wallpaper selection menu `rofi/modes/wallpaper-menu.sh` handles thumbnail caching, dry-run optimizations, and theme generation:

**Scanning & Caching:**
Reads images from `~/.config/wallpapers` and generates corresponding thumbnails in `~/.config/cache/thumbnails/`.

**Color Preview Cache:**
Runs matugen with the `--dry-run` flag for every possible `--prefer` setting, caching the potential color palettes as JSON files alongside the thumbnails. (Skips generation if thumbnails/JSON files already exist).

**Garbage Collection:**
Automatically cleans up orphaned thumbnails and JSON files if their source wallpaper has been deleted.

**Interactive Selection:**
Opens a custom Rofi menu allowing you to visually pick a wallpaper and your preferred Matugen color mode.

**Execution:**
Triggers matugen for real using the selected image and mode.
It also generates a blurred variant of the wallpaper in `~/.config/cache` for use in hyprlock and rofi backgrounds.

**Automated Theme Dissemination:**
Once Matugen ingests the selected wallpaper parameters, it regenerates and applies colors dynamically across the entire ecosystem.

- Terminal: Kitty
- Shell/Environment: Hyprland, Hyprlock
- UI & Launchers: Rofi, Waybar, SwayNC
- Toolkit Styling: GTK3, GTK4
- System Icons: Custom integration with papirus-folders.

> [!WARNING]
> This will replace your `~/.config/gtk-3.0/gtk.css` and `~/.config/gtk-4.0/gtk.css`

> [!NOTE]
> ***Papirus Folders Integration:*** Because how you install the papirus-folders script may vary, you might want to edit the last lines of `~/.dotfiles/scripts/foldier_color.sh` to point it to where you keep the script. The current script expects it to exist in `~/.local/bin/papirus-folders`.

