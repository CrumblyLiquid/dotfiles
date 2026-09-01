-- Window rules

-- Enable tearing for different games
hl.window_rule({
	name = "cs2",
	match = { class = "^(cs2)$" },
	immediate = true,
})

hl.window_rule({
	name = "kingdom-come-deliverance",
	match = { class = "^(steam_app_379430)$" },
	immediate = true,
})

hl.window_rule({
	name = "rocket-league",
	match = { class = "^(steam_app_252950)$" },
	immediate = true,
})

hl.window_rule({
	name = "osu",
	match = { title = "^(osu!)$" },
	immediate = true,
})

hl.window_rule({
	name = "hollow-knight",
	match = { title = "^(Hollow Knight)$" },
	immediate = true,
})

-- Steam windows losing focus fix
hl.window_rule({
	name = "steam-fix",
	match = { title = "^()$", class = "^(steam)$" },
	stay_focused = true,
	min_size = { 1, 1 },
})

-- JetBrains stuff
hl.window_rule({
	match = { class = "^(jetbrains-.*)" },
	no_initial_focus = true,
	opacity = "0.9 0.9",
})

hl.window_rule({
	name = "jetbrains-win-fix",
	match = { class = "^(jetbrains-.*)", title = "^(win.*)" },
	float = true,
})

hl.window_rule({
	name = "jetbrains-focus-fix",
	match = { class = "^(jetbrains-.*)" },
	no_initial_focus = true,
	opacity = "0.9 0.9",
})

-- XWayland Video Bridge
-- https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/#xwayland)
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = "0.0",
})
