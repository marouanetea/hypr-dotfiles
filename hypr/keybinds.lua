-- =========================================================================
-- Variables & Core Bind Modifiers
-- =========================================================================
local general = require("general")
local functions = require("functions")
-- =========================================================================
-- Window & Program Shortcuts
-- =========================================================================

-- Lock
hl.bind(general.mainMod  .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Window commands
hl.bind(general.mainMod  .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(general.mainMod .. " + RETURN", functions.cycle_float_center)

-- Program shortcuts
hl.bind(general.mainMod  .. " + T", hl.dsp.exec_cmd(general.terminal))
hl.bind(general.mainMod  .. " + F", hl.dsp.exec_cmd(general.fileManager))
hl.bind(general.mainMod  .. " + B", hl.dsp.exec_cmd(general.browser))
hl.bind(general.mainMod  .. " + M", hl.dsp.exec_cmd(general.musicPlayer))
hl.bind(general.mainMod  .. " + G", hl.dsp.exec_cmd(general.game))

-- Custom rofi menus
hl.bind(general.mainMod  .. " + SPACE", hl.dsp.exec_cmd(general.menu))
hl.bind(general.mainMod  .. " + W", hl.dsp.exec_cmd(general.wallpaperMenu))
hl.bind(general.mainMod  .. " + DELETE", hl.dsp.exec_cmd(general.powerMenu))
hl.bind(general.mainMod  .. " + S", hl.dsp.exec_cmd(general.socialMenu))
hl.bind(general.mainMod  .. " + V", hl.dsp.exec_cmd(general.cliphistMenu))

-- Mouse 
hl.bind(general.mainMod  .. " + mouse:272", hl.dsp.window.drag())
hl.bind(general.mainMod  .. " + mouse:273", hl.dsp.window.resize())

-- Emergency
hl.bind("SUPER + ALT + CTRL + ESCAPE", hl.dsp.exec_cmd(general.shutDown))
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

  hl.bind(general.mainMod .. " + code:" .. keycode, hl.dsp.focus(workspace))

  -- Move active window to workspace (e.g., SUPER ALT + code:10 -> movetoworkspace 1)
  hl.bind(general.mainMod .. " + ALT + code:" .. keycode, hl.dsp.window.move (workspace))
end

-- =========================================================================
-- Relative Workspace Navigation
-- =========================================================================

-- Switch workspace +-1
hl.bind(general.mainMod .. " + right", hl.dsp.focus({ workspace = tostring("r+1") }))
hl.bind(general.mainMod .. " + left",  hl.dsp.focus({ workspace = tostring("r-1") }))

-- Move active window to workspace +-1
hl.bind(general.mainMod .. " + ALT + right",  hl.dsp.window.move ({ workspace = tostring("r+1") }))
hl.bind(general.mainMod .. " + ALT + left",  hl.dsp.window.move ({ workspace = tostring("r-1") }))


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
hl.bind(general.mainMod .. " + F9", hl.dsp.exec_cmd( "swayosd-client --output-volume mute-toggle"))
hl.bind(general.mainMod .. " + F10",hl.dsp.exec_cmd( "swayosd-client --output-volume mute-toggle"))

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
hl.bind(general.mainMod .. " + KP_Begin",       	hl.dsp.exec_cmd( "playerctl play-pause"))
hl.bind(general.mainMod .. " + KP_Right",       	hl.dsp.exec_cmd( "playerctl next"))
hl.bind(general.mainMod .. " + KP_Left",       	hl.dsp.exec_cmd( "playerctl previous"))

-- =========================================================================
-- hyprshot
-- =========================================================================
hl.bind("Print",       	hl.dsp.exec_cmd( "hyprshot -m output -m eDP-1 -o ~/Pictures/screenshots"))
hl.bind("ALT + Print",       	hl.dsp.exec_cmd( "hyprshot -m window -m active -o ~/Pictures/screenshots"))
hl.bind(general.mainMod .. " + Print",       	hl.dsp.exec_cmd( "hyprshot -m region -m eDP-1 -o ~/Pictures/screenshots"))






