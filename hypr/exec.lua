-- =========================================================================
-- Autostart & Initial Environment Customization
-- =========================================================================

hl.on("hyprland.start", function ()
  -- Pretend we are GNOME for nautilus to respect gsettings
  hl.env("XDG_CURRENT_DESKTOP", "GNOME")
  hl.env("XDG_MENU_PREFIX", "gnome-")

  -- Update the DBus and systemd activation environments
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=GNOME")

  -- Startup applications & system tray daemons
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("waybar")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("swaync")
  hl.exec_cmd("swayosd-server")
end)
