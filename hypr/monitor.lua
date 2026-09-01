hl.monitor({
	output = "",
	mode = "highres@highrr",
	position = "auto",
	scale = 1,
	vrr = 1,
	bitdepth = 8,
})

local dell = "desc:Dell Inc. DELL G2724D 1LLZ5Y3"
hl.monitor({
	output = dell,
	mode = "highres@highrr",
	vrr = 1,
	position = "0x0",
})

local eizo = "desc:Eizo Nanao Corporation EV2795 29101100"
hl.monitor({
	output = eizo,
	mode = "highres@highrr",
	position = "auto-left",
	-- transform = 3,
})

for id = 1, 10 do
	hl.workspace_rule({
		workspace = string(id),
		monitor = dell,
		default = true,
	})
end

for id = 11, 15 do
	hl.workspace_rule({
		workspace = string(id),
		monitor = eizo,
		default = true,
	})
end
