-- =========================================================================
-- Layer Rules
-- =========================================================================

hl.layer_rule({
	match = { namespace = "waybar" }, 
	blur = true,
	ignore_alpha = 0.1
})

hl.layer_rule({
	match = { namespace = "rofi" }, 
	blur = true,
	ignore_alpha = 0.1
})


-- =========================================================================
-- Window Rules
-- =========================================================================

-- Specific window opacity settings for kitty
hl.window_rule({
  match = { class = "kitty" },
  opacity = "0.8 override 0.7 override 1.0 override",
})

-- Specific window opacity settings for music player, ie Amberol
hl.window_rule({
  match = { class = "io.bassi.Amberol" },
  opacity = "0.9 override 0.8 override 1.0 override",
})

-- Specific window opacity settings for video player, always opaque
hl.window_rule({
  match = { class = "^(io.github.celluloid_player.Celluloid)$" },
  opacity = "1.0 override 1.0 override 1.0 override",
})

-- For games 
hl.window_rule({
  match = { class = "^(steam_app.*)$" },
  opacity = "1.0 override 1.0 override 1.0 override",
  float = true,
  render_unfocused = true,
  max_size = {1280, 720},
})
hl.window_rule({
  match = { class = "^(pcsx2-qt.*)$" },
  opacity = "1.0 override 1.0 override 1.0 override",
  float = true,
  render_unfocused = true,
  max_size = {1280, 720},
})
