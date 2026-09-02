---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
---@return HL.Keybind
local bind = function(keys, dispatcher, opts)
	local mod = "ALT"
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

for key, id in pairs(workspaces) do
	bind(key, hl.dsp.focus({ workspace = id }), { description = "Switch to workspace " .. tostring(id) })
	bind(
		"SHIFT + " .. key,
		hl.dsp.window.move({ workspace = id }),
		{ description = "Move window to workspace " .. tostring(id) }
	)
end

bind("mouse_up", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to the next workspace" })
bind("mouse_down", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to the previous workspace" })

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
		{ description = "Move window to '" .. direction .. "'" }
	)
end

bind("mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag the window with a mouse" })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize the window with a mouse" })

-- TODO: Group keybinds

hl.bind("CONTROL + ALT + K", function()
	for keyboard in { "at-translated-set-2-keyboard", "keychron-keychron-k8-pro-keyboard" } do
		hl.dsp.exec_cmd("hyprctl switchxkblayout " .. keyboard .. " next")
	end
end, { locked = true, description = "Switch keyboard layout" })

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
hl.bind("SUPER + SHIFT + Print", hl.dsp.exec_cmd("grimblast copy area --freeze --notify"))

-- Caps Lock OSD
hl.bind("Caps_Lock", hl.dsp.exec_cmd("~/.config/eww/scripts/caps-osd"))

-- Lock screen activation
hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))
