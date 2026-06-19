-- =========================================================================
-- Global / Configuration Variables
-- =========================================================================

-- Shutdown command
_G.shutDown = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"

-- Main mod
_G.mainMod     = "SUPER"

-- Prefered programs
_G.terminal    = "kitty"
_G.fileManager = "nautilus"
_G.browser = "chromium"
_G.musicPlayer = "g4music"

-- List of menus
_G.menu           = "rofi -show drun -config main.rasi"
_G.wallpaperMenu  = "rofi -show wallpaper -config wallpaper.rasi"
_G.powerMenu      = "rofi -show power -config power.rasi"
_G.socialMenu     = "rofi -show social -config social.rasi"
_G.cliphistMenu   = "cliphist list | rofi -dmenu -config cliphist.rasi -display-columns 2 -sep '\n'  | cliphist decode | wl-copy"

-- X wayland compatibility
hl.config({
	xwayland = {
		force_zero_scaling = true
	}
})
