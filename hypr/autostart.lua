hl.on("hyprland.start", function()
	-- Autostart important processes
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

	-- Autostart other
	hl.exec_cmd("wpaperd -d")

	-- Start memory monitoring script
	hl.exec_cmd("~/.config/scripts/memory_monitor")

	-- Start battery monitoring script
	hl.exec_cmd("~/.config/scripts/battery_monitor")

	-- I'm not using bar but I'm still using
	-- the Caps Lock OSD
	hl.exec_cmd("eww daemon")
	hl.exec_cmd("eww update laptop_mode={{laptop_mode}}")
	-- hl.exec_cmd("eww open bar")

	hl.exec_cmd("hypridle")

	-- Set cursor size
	hl.exec_cmd("hyprctl setcursor {{cursor}} {{cursor_size}}")
end)
