---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
---@return HL.Keybind
local bind = function(keys, dispatcher, opts)
	local mod = "SUPER"
	return hl.bind(mod .. " + " .. keys, dispatcher, opts)
end

---@param keys string
---@param program string
---@return HL.Keybind
local launch = function(keys, program)
	return bind(keys, hl.dsp.exec_cmd(program), { description = "Launches " .. program })
end

launch("Q", "kitty")
launch("W", "librewolf")
launch("E", "dolphin")
launch("R", "tofi-drun --drun-launch=true")
launch("Z", "~/.config/tofi/scripts/switch_output")

bind("C", hl.dsp.window.close(), { description = "Closes the currently focused window" })
bind("SHIFT + C", hl.dsp.window.kill(), { description = "Kills the currently focused window" })
bind("SHIFT + M", hl.dsp.exit(), { description = "Exits the current session" })
bind("T", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reloads Hyprland configuration" })

bind("F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bind("apostrophe", hl.dsp.window.float({ action = "toggle" }))

-- TODO: https://wiki.hypr.land/configuring/code-snippets/
-- Dwindle layout
bind("semicolon", hl.dsp.layout("togglesplit"))
bind("bracketleft", hl.dsp.window.pseudo())

local workspaces = {
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
	["0"] = 10,
	["y"] = 11,
	["u"] = 12,
	["i"] = 13,
	["o"] = 14,
	["p"] = 15,
}

-- Modified version of https://forum.hypr.land/t/moving-closing-all-windows-in-current-workspace/1662/5
local function move_all_windows(target_workspace)
	local active_workspace = hl.get_active_workspace()
	local windows = hl.get_windows({ workspace = active_workspace })

	for _, window in pairs(windows) do
		hl.dispatch(hl.dsp.window.move({
			window = window,
			workspace = target_workspace,
		}))
	end
end

for key, id in pairs(workspaces) do
	bind(key, hl.dsp.focus({ workspace = id }), { description = "Switch to workspace " .. tostring(id) })
	bind(
		"SHIFT + " .. key,
		hl.dsp.window.move({ workspace = id }),
		{ description = "Move window to workspace " .. tostring(id) }
	)
	bind("CONTROL + SHIFT + " .. key, function()
		move_all_windows(id)
	end, { description = "Move all windows from the current workspace to workspace " .. tostring(id) })
end

bind("mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to the next workspace" })
bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to the previous workspace" })

local directions = {
	-- HJKL
	["h"] = "l",
	["j"] = "d",
	["k"] = "u",
	["l"] = "r",
	-- Arrows
	["left"] = "l",
	["right"] = "r",
	["up"] = "u",
	["down"] = "d",
}

for key, direction in pairs(directions) do
	bind(key, hl.dsp.focus({ direction = direction }), { description = "Move focus to '" .. direction .. "'" })
	bind(
		"SHIFT + " .. key,
		hl.dsp.window.move({ direction = direction }),
		{ description = "Swap window to '" .. direction .. "'" }
	)
	bind(
		"CONTROL + " .. key,
		hl.dsp.window.swap({ direction = direction }),
		{ description = "Move window to '" .. direction .. "'" }
	)
end

bind("mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag the window with a mouse" })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize the window with a mouse" })

-- Resize mode
bind("X", hl.dsp.submap("resize"), { description = "Enter resize mode" })
hl.define_submap("resize", function()
	local step = 40
	local deltas = {
		h = { -step, 0 },
		l = { step, 0 },
		k = { 0, -step },
		j = { 0, step },
		left = { -step, 0 },
		right = { step, 0 },
		up = { 0, -step },
		down = { 0, step },
	}
	for key, d in pairs(deltas) do
		hl.bind(key, hl.dsp.window.resize({ x = d[1], y = d[2], relative = true }), { repeating = true }) -- ⚠ arg shape
	end
	bind("X", hl.dsp.submap("reset"))
end)

-- Maximize: keeps gaps and borders, unlike real fullscreen
bind("M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Maximize window" })

-- Pin a floating window so it follows you across workspaces (PiP video, calculator)
bind("B", hl.dsp.window.pin(), { description = "Pin floating window" })

-- Center a floating window (sits next to the float toggle)
bind("SHIFT + apostrophe", hl.dsp.window.center(), { description = "Center floating window" })

-- Jump back to the previous workspace
bind("grave", hl.dsp.focus({ workspace = "previous" }), { description = "Previous workspace" })

-- Jump to the window that is demanding attention (e.g. a Discord ping)
bind("N", function()
	local w = hl.get_urgent_window()
	if w then
		hl.dispatch(hl.dsp.focus({ window = w }))
	end
end, { description = "Focus urgent window" })

-- Groups
bind("G", hl.dsp.group.toggle(), { description = "Create/dissolve group" })
bind("TAB", hl.dsp.group.next(), { description = "Next window in group" })
bind("SHIFT + TAB", hl.dsp.group.prev(), { description = "Previous window in group" })
bind("SHIFT + G", hl.dsp.group.lock({ action = "toggle" }), { description = "Lock active group" })
bind("CONTROL + G", hl.dsp.window.deny_from_group({ action = "toggle" }), { description = "Deny window from groups" })

-- Move into/out of a neighbouring group
for key, direction in pairs(directions) do
	bind(
		"CONTROL + SHIFT + " .. key,
		hl.dsp.window.move({ direction = direction, group_aware = true }),
		{ description = "Move window into/out of group '" .. direction .. "'" }
	)
end

-- local keyboards = { [1] = "at-translated-set-2-keyboard", [2] = "keychron-keychron-k8-pro-keyboard" }
-- for _, keyboard in pairs(keyboards) do
-- 	hl.bind(
-- 		"CONTROL + SUPER + K",
-- 		hl.dsp.exec_cmd("hyprctl switchxkblayout " .. keyboard .. " next"),
-- 		{ locked = true, description = "Switch keyboard layout" }
-- 	)
-- end

local toggle_layout_cmd = hl.dsp.exec_cmd(
	"if hyprctl devices -j | jq -e '.keyboards[] | select(.main == true and .active_layout_index == 0)' >/dev/null; then hyprctl keyword input:kb_options '' && hyprctl switchxkblayout all 2; else hyprctl keyword input:kb_options 'grp:caps_switch,grp:switch' && hyprctl switchxkblayout all 0; fi"
)
hl.bind("SUPER + Shift_L", toggle_layout_cmd, { locked = true, description = "Switch keyboard layout" })
hl.bind("SHIFT + Super_L", toggle_layout_cmd, { locked = true, description = "Switch keyboard layout" })

local brightness_actions = {
	["Up"] = "up",
	["Down"] = "down",
}

for key, action in pairs(brightness_actions) do
	hl.bind(
		"XF86MonBrightness" .. key,
		hl.dsp.exec_cmd("~/.config/scripts/brightness " .. action .. " 5"),
		{ locked = true }
	)
end

local volume_actions = {
	["RaiseVolume"] = "up",
	["LowerVolume"] = "down",
	["Mute"] = "mute",
}

for key, action in pairs(volume_actions) do
	for node, modifier in pairs({ ["out"] = "", ["in"] = "SHIFT" }) do
		hl.bind(
			modifier .. " + XF86Audio" .. key,
			hl.dsp.exec_cmd("~/.config/scripts/volume " .. node .. " " .. action),
			{ locked = true, repeating = true }
		)
	end
end

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/scripts/volume in mute"))

local music_actions = {
	["Prev"] = "previous",
	["Next"] = "next",
	["Play"] = "play",
}

for key, action in pairs(music_actions) do
	hl.bind("XF86Audio" .. key, hl.dsp.exec_cmd("~/.config/scripts/music " .. action), { locked = true })
end

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy screen --notify --freeze --cursor"))
hl.bind("ALT + SHIFT + Print", hl.dsp.exec_cmd("grimblast copy area --freeze --notify"))

-- Caps Lock OSD
hl.bind("Caps_Lock", hl.dsp.exec_cmd("~/.config/eww/scripts/caps-osd"))

-- Lock screen activation
hl.bind("ALT + L", hl.dsp.exec_cmd("loginctl lock-session"))
