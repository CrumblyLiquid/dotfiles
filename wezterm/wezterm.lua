local wezterm = require('wezterm');

local config = wezterm.config_builder();

-- Colors
config.color_scheme = 'Catppuccin Mocha';
-- config.window_background_opacity = 0.95;

-- Font
config.font = wezterm.font('MesloLGS NF', { stretch = 'Expanded' });
config.font_size = 16.0;

-- User interface
config.enable_scroll_bar = true;
config.enable_tab_bar = false;

-- Hide the unfilled space
-- https://github.com/wezterm/wezterm/issues/5561
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}

return config;
