hl.config({
	general = {
		-- TODO: Maybe conditionally disable on laptop
		allow_tearing = true,
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg",
			inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
	},
	dwindle = {
		preserve_split = true,
		force_split = 2,
	},
	master = {
		new_status = "master",
		mfact = 0.5,
	},
	decoration = {
		rounding = 4,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			new_optimizations = true,
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
	},
})
