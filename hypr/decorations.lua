-- =========================================================================
-- Visual Theme (Borders, Gaps, Blur & Opacity)
-- =========================================================================

local colors = require ("colors")

hl.config(
{
	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 1,

		-- Glass-style borders
		col={
			active_border = colors.primary_col,
			inactive_border = colors.secondary_col,
		},
	},

	decoration = {
		rounding = 10,

		-- Opacity settings
		active_opacity = 0.9,       -- Opacity for the focused window
		inactive_opacity = 0.8,     -- Opacity for unfocused windows
		fullscreen_opacity = 1.0,   -- Opacity for fullscreen windows

		blur = {
			enabled = true,
			size = 7,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			contrast = 1.5,
			noise = 0.02,
			brightness = 0.9,
		},

		shadow = {
			enabled = true,
			range = 15,
			render_power = 4,
			color = "0x44000000",          -- Hex ARGB notation
			color_inactive = "0x22000000", -- Hex ARGB notation
		},

		dim_around = 0.8
	},
})
