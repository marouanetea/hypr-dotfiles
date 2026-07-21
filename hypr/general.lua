-- =========================================================================
-- Global / Configuration Variables
-- =========================================================================

local general = {
	-- Shutdown command
	shutDown = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit",

	-- Main mod
	mainMod     = "SUPER",

	-- Prefered programs
	terminal    = "kitty",
	fileManager = "nautilus",
	browser = "chromium",
	musicPlayer = "g4music",

	-- List of menus
	menu           = "rofi -show drun -config main.rasi",
	wallpaperMenu  = "~/.config/rofi/modes/wallpaper-menu.sh",
	powerMenu      = "rofi -show power -config power.rasi",
	socialMenu     = "rofi -show social -config social.rasi",
	cliphistMenu   = "cliphist list | rofi -dmenu -config cliphist.rasi -display-columns 2 -sep '\n'  | cliphist decode | wl-copy",

	-- Game launcher
	game = "lutris"
}

return general
