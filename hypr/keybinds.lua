---@param keys string
---@param dispatcher HL.Dispatcher|function
---@param opts HL.BindOptions?
---@return HL.Keybind
local bind = function(keys, dispatcher, opts)
	local mod = "ALT"
	return hl.bind(mod + " + " + keys, dispatcher, opts)
end

---@param keys string
---@param program string
---@return HL.Keybind
local launch = function(keys, program)
	return bind(keys, hl.dsp.exec_cmd(program), { description = "Launches " + program })
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

bind("F", hl.dsp.window.fullscreen({ mode = "fulscreen", action = "toggle" }))
bind("apostrophe", hl.dsp.window.float({ action = "toggle" }))

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
	bind(key, hl.dsp.focus({ workspace = id }))
	bind(key, hl.dsp.window.move({ workspace = id }))
end

bind("mouse_up", hl.dsp.focus({ workspace = "e+1" }))
bind("mouse_down", hl.dsp.focus({ workspace = "e-1" }))
