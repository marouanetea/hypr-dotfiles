-- =========================================================================
-- Variables & Core Bind Modifiers
-- =========================================================================

-- =========================================================================
-- Window & Program Shortcuts
-- =========================================================================

-- Lock
hl.bind(_G.mainMod  .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Window commands
hl.bind(_G.mainMod  .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(_G.mainMod .. " + RETURN", _G.cycle_float_center)

-- Program shortcuts
hl.bind(_G.mainMod  .. " + T", hl.dsp.exec_cmd(_G.terminal))
hl.bind(_G.mainMod  .. " + F", hl.dsp.exec_cmd(_G.fileManager))
hl.bind(_G.mainMod  .. " + B", hl.dsp.exec_cmd(_G.browser))
hl.bind(_G.mainMod  .. " + M", hl.dsp.exec_cmd(_G.musicPlayer))
hl.bind(_G.mainMod  .. " + G", hl.dsp.exec_cmd(_G.game))

-- Custom rofi menus
hl.bind(_G.mainMod  .. " + SPACE", hl.dsp.exec_cmd(_G.menu))
hl.bind(_G.mainMod  .. " + W", hl.dsp.exec_cmd(_G.wallpaperMenu))
hl.bind(_G.mainMod  .. " + DELETE", hl.dsp.exec_cmd(_G.powerMenu))
hl.bind(_G.mainMod  .. " + S", hl.dsp.exec_cmd(_G.socialMenu))
hl.bind(_G.mainMod  .. " + V", hl.dsp.exec_cmd(_G.cliphistMenu))

-- Mouse 
hl.bind(_G.mainMod  .. " + mouse:272", hl.dsp.window.drag())
hl.bind(_G.mainMod  .. " + mouse:273", hl.dsp.window.resize())

-- Emergency
hl.bind("SUPER + ALT + CTRL + ESCAPE", hl.dsp.exec_cmd(_G.shutDown))
hl.bind("ALT + CTRL + DELETE", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("SHIFT + CTRL + DELETE", hl.dsp.exec_cmd("[float; center; size 1000 700] kitty htop"))
hl.bind("CTRL + DELETE", hl.dsp.exec_cmd("[float; center; size 1000 700] gnome-system-monitor"))

-- =========================================================================
-- Workspaces (Generated via Loop)
-- =========================================================================

-- Loops through keycodes 10 (Key 1) to 19 (Key 0)
for i = 1, 9 do
	local keycode = 10 + i
	local workspace = { workspace = tostring(i) }

  hl.bind(_G.mainMod .. " + code:" .. keycode, hl.dsp.focus(workspace))

  -- Move active window to workspace (e.g., SUPER ALT + code:10 -> movetoworkspace 1)
  hl.bind(_G.mainMod .. " + ALT + code:" .. keycode, hl.dsp.window.move (workspace))
end

-- =========================================================================
-- Relative Workspace Navigation
-- =========================================================================

-- Switch workspace +-1
hl.bind(_G.mainMod .. " + right", hl.dsp.focus({ workspace = tostring("r+1") }))
hl.bind(_G.mainMod .. " + left",  hl.dsp.focus({ workspace = tostring("r-1") }))

-- Move active window to workspace +-1
hl.bind(_G.mainMod .. " + ALT + right",  hl.dsp.window.move ({ workspace = tostring("r+1") }))
hl.bind(_G.mainMod .. " + ALT + left",  hl.dsp.window.move ({ workspace = tostring("r-1") }))


-- =========================================================================
-- Audio shortcuts 
-- =========================================================================

-- Laptop
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd( "swayosd-client --output-volume raise"))
hl.bind("XF86AudioLowerVolume",	hl.dsp.exec_cmd( "swayosd-client --output-volume lower"))
hl.bind("XF86AudioMute",       	hl.dsp.exec_cmd( "swayosd-client --output-volume mute-toggle"))

-- Keyboard
hl.bind("F10", hl.dsp.exec_cmd( "swayosd-client --output-volume raise"), {repeating = true})
hl.bind("F9",  hl.dsp.exec_cmd( "swayosd-client --output-volume lower"), {repeating = true})
hl.bind(_G.mainMod .. " + F9", hl.dsp.exec_cmd( "swayosd-client --output-volume mute-toggle"))
hl.bind(_G.mainMod .. " + F10",hl.dsp.exec_cmd( "swayosd-client --output-volume mute-toggle"))

-- =========================================================================
-- Screen brightness controls
-- =========================================================================

-- Laptop
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd( "swayosd-client --brightness raise"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd( "swayosd-client --brightness lower"))
-- Keyboar
hl.bind("F12", hl.dsp.exec_cmd( "swayosd-client --brightness raise"), {repeating = true})
hl.bind("F11", hl.dsp.exec_cmd( "swayosd-client --brightness lower"), {repeating = true})

-- =========================================================================
-- Media playback
-- =========================================================================
hl.bind(_G.mainMod .. " + KP_Begin",       	hl.dsp.exec_cmd( "playerctl play-pause"))
hl.bind(_G.mainMod .. " + KP_Right",       	hl.dsp.exec_cmd( "playerctl next"))
hl.bind(_G.mainMod .. " + KP_Left",       	hl.dsp.exec_cmd( "playerctl previous"))

-- =========================================================================
-- hyprshot
-- =========================================================================
hl.bind("Print",       	hl.dsp.exec_cmd( "hyprshot -m output -m eDP-1 -o ~/Pictures/screenshots"))
hl.bind("ALT + Print",       	hl.dsp.exec_cmd( "hyprshot -m window -m active -o ~/Pictures/screenshots"))
hl.bind(_G.mainMod .. " + Print",       	hl.dsp.exec_cmd( "hyprshot -m region -m eDP-1 -o ~/Pictures/screenshots"))






