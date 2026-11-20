hl.config({
	group = {
		drag_into_group = 1,
		merge_groups_on_drag = true,

		col = {
			border_active = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			border_inactive = "rgba(595959aa)",
			border_locked_active = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			border_locked_inactive = "rgba(595959aa)",
		},

		groupbar = {
			font_size = 13,
			font_family = "MesloLGS Nerd Font Mono",
			font_weight_active = "bold",
			font_weight_inactive = "normal",
			indicator_height = 0,
			indicator_gap = 5,
			height = 20,
			gaps_in = 5,
			gaps_out = 0,
			scrolling = false,

			text_color = "rgb(000000)",
			text_color_inactive = "rgba(ffffff90)",
			col = { active = "rgba(33ccffcc)", inactive = "rgba(303030cc)" },

			gradients = true,
			gradient_rounding = 6,
			gradient_round_only_edges = false,
			blur = true,

			middle_click_close = true,
		},
	},
})
