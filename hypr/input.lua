hl.config({
	input = {
		kb_layout = "us,cz",
		kb_variant = ",qwerty",

		-- kb_model = "",
		-- I'm using specific keybind (CTRL+ALT+K)
		-- kb_options = "grp:alt_shift_toggle",
		-- kb_rules = "",

		follow_mouse = 2,

		touchpad = {
			natural_scroll = true,
		},

		sensitivity = 0,
	},
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "logitech-g-pro--1",
	sensitivity = -0.6,
})
