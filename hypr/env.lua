-- =========================================================================
-- Environment Variables
-- =========================================================================

-- Force hyprland as the current desktop, because of GDM forcing it to be gnome
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)


-- Add local home to path
local current_path = os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin"
local current_home = os.getenv("HOME")
hl.env("PATH",current_home ..  "/.local/bin:" .. current_path)

-- GTK Scaling
hl.env("GDK_SCALE", "1.25")

-- Qt Scaling (Important for apps like OBS, VLC, or KDE-based tools)
hl.env("QT_ENABLE_HIGHDPI_SCALING","1.25")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1.25")

-- Wayland-specific backend hints
hl.env("MOZ_ENABLE_WAYLAND", "1") -- For Firefox/Thunderbird

-- Curso theme & scaling
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE","25")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE","25")

-- Force Mesa (Intel) as the default GLX provider
hl.env("__GLX_VENDOR_LIBRARY_NAME", "mesa")

-- Explicitly disable Nvidia offloading by default
hl.env("__NV_PRIME_RENDER_OFFLOAD", "0")

-- Tell vulkan to sort the intel ship first, for GTK to use intel 
hl.env("VK_LOADER_DEVICE_SELECT", "8086")

-- X wayland compatibility
hl.config({
	xwayland = {
		force_zero_scaling = true
	}
})
