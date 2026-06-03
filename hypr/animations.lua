-- 1. Enable the global animation engine
hl.config({
    animations = {
        enabled = true
    }
})

-- 2. Define Custom Bezier Curves
-- Syntax: hl.curve("NAME", { type = "bezier", points = { {x1, y1}, {x2, y2} } })
hl.curve("ease-in-out",  { type = "bezier", points = { {0.6, 0.2}, {0.4, 0.8} } })
hl.curve("ease-in",      { type = "bezier", points = { {0.6, 0.2}, {0.8, 0.8} } })
hl.curve("ease-out",      { type = "bezier", points = { {0.2, 0.2}, {0.4, 0.8} } })

-- 3. Define Spring Physic Curves (Alternative to Bezier)
-- hl.curve("snappy_spring", { type = "spring", settling_duration = 0.5, damping = 0.7 })

-- 4. Map Curves to Animation Tree Elements
-- Note: Speed is defined in deciseconds (1ds = 100ms)
hl.animation({ leaf = "windows",     enabled = true, speed = 2,   bezier = "ease-in-out",     style = "slide" })

hl.animation({ leaf = "workspaces",  enabled = true, speed = 2, bezier = "ease-in", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "ease-in", style = "slidefadevert" })

hl.animation({ leaf = "fade",        enabled = true, speed = 2,   bezier = "ease-out" })
hl.animation({ leaf = "layers",      enabled = true, speed = 2, bezier = "ease-out",    style = "fade" })
