-- =========================================================================
-- Custom lua functions
-- =========================================================================
_G.cycle_float_center = function()
	local w = hl.get_active_window()

	if w == nil then return end
	
	if w.fullscreen  > 0  then
		hl.dispatch(hl.dsp.window.fullscreen({ action = "unset" }))
		hl.dispatch(hl.dsp.window.float({ action = "unset" }))

	elseif w.floating then
		hl.dispatch(hl.dsp.window.fullscreen({ action = "set" }))
	else
		hl.dispatch(hl.dsp.window.float({ action = "set" }))
		hl.dispatch(hl.dsp.window.center({ action = "set" }))
	end
end
