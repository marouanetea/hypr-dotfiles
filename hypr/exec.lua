-- =========================================================================
-- Autostart & Initial Environment Customization
-- =========================================================================

hl.on("hyprland.start", function ()

	-- Update the DBus and systemd activation environments
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=GNOME")

	-- Startup applications & system tray daemons
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("swaync")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("hypridle")

	-- Clipboard manager	 
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")	
end)
