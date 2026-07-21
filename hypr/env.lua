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
