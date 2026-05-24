-- =========================================================================
-- Monitors
-- =========================================================================

hl.monitor({
  output = "eDP-1",
  mode = "1920x1080",
  position = "0x0",
  scale = 1.2,
})

-- =========================================================================
-- Environment Variables
-- =========================================================================

-- GTK Scaling
hl.env("GDK_SCALE", "1.25")

-- Qt Scaling (Important for apps like OBS, VLC, or KDE-based tools)
hl.env("QT_ENABLE_HIGHDPI_SCALING","1.25")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR","1.25")

-- Wayland-specific backend hints
hl.env("MOZ_ENABLE_WAYLAND", "1") -- For Firefox/Thunderbird

-- Cursor scaling
hl.env("XCURSOR_SIZE","24")
hl.env("HYPRCURSOR_SIZE","24")
