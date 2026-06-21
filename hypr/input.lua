-- =========================================================================
-- Input & Cursor Settings
-- =========================================================================

hl.config({
	input = {
		-- Specify the layouts separated by a comma
		kb_layout = "fr,ara",

		-- Specify the toggle shortcut to changing keyboard
		kb_options = "grp:alt_shift_toggle",

		-- Mouse options
		follow_mouse = 0,
		sensitivity = 0.3,
		accel_profile = "flat",

		-- Default numlock
		numlock_by_default = true,

		-- Touch pad scroll
		touchpad = {
			natural_scroll = false, 
			scroll_factor = 2.0,
		},
  	},

	cursor = {
		no_warps = true,
	},
})

hl.device({
	name = "synps/2-synaptics-touchpad",
	sensitivity = 0.35,
	accel_profile = "adaptive",     
})
