-- =========================================================================
-- Hyprland Main Entry Point
-- =========================================================================

-- 1. Core Configurations & Inputs
require("env")
require("monitors")
require("input")

-- 2. Themes & Looks
require("decorations")
-- require("animations") -- Uncomment when you port your animation curves!

-- 3. Rules & Actions
require("rules")

-- 4. Window Keybinds & Shortcuts
require("keybinds")

-- 5. Autostart Applications
require("exec")

-- 6. Animations
require("animations")
