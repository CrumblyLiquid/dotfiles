local wezterm = require('wezterm');

local config = wezterm.config_builder();

-- Colors
config.color_scheme = 'Catppuccin Mocha';
config.window_background_opacity = 0.90;

-- Font
config.font = wezterm.font('MesloLGS NF', { weight = 'Bold', stretch = 'Expanded' });
config.font_size = 16.0;

-- User interface
config.enable_scroll_bar = true;
config.enable_tab_bar = false;

return config;
