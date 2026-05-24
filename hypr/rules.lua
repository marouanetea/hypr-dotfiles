-- =========================================================================
-- Layer Rules
-- =========================================================================

hl.layer_rule({
  match = { namespace = "wlogout" },
  blur = true,
  dim_around = true,
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
