-- =========================================================================
-- Hyprland Main Entry Point
-- =========================================================================

-- 1. Load configuration variables & theme colors
require("colors")

-- 2. Core Configurations & Inputs
require("env")
require("monitors")
require("input")
require("general")
require("custom_functions")

-- 3. Themes & Looks
require("decorations")
-- require("animations") -- Uncomment when you port your animation curves!

-- 4. Rules & Actions
require("rules")

-- 5. Window Keybinds & Shortcuts
require("keybinds")

-- 6. Autostart Applications
require("exec")

-- 7. Animations
require("animations")
