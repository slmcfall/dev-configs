-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- appearance
config.color_scheme = 'Tokyo Night'
config.colors = {
  background = '#1b1f30'
}
config.font = wezterm.font 'BlexMono Nerd Font Mono'
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0cell',
}

-- and finally, return the configuration to wezterm
return config
