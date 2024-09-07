-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",

	font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" }),

	font_size = 16,
	color_scheme = "Ayu Dark",
	default_cursor_style = "BlinkingBar",

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	background = {
		{
			source = {
				-- File = "/Users/marlon/Pictures/wallpaper/1-10881_mac-os-mojave-wallpaper-4k.jpg",
				--				File = "/Users/marlon/Pictures/wallpaper/wallpapersden.com_macos-12-monterey-digital_3840x2160.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/metallic-pink.png",
				-- File = "/Users/marlon/Pictures/wallpaper/broken-glass-pieces-red-4k-at.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/glass-blurred.jpg",
				File = "/Users/marlon/Pictures/wallpaper/blurred-colours.jpg",
			},
			hsb = {
				hue = 1.0,
				saturation = 1.02,
				brightness = 0.95,
			},
			width = "100%",
			height = "100%",
			opacity = 0.85,
		},
		{
			source = {
				-- Color = "#242937",
				-- Color = "#282c35",
				Color = "#ffffff",
				--	Color = "#720041",
			},
			hsb = {
				hue = 1.0,
				saturation = 1,
				brightness = 0.55,
			},
			width = "100%",
			height = "100%",
			opacity = 0.25,
		},
		{
			source = {
				Color = "#242937",
				-- Color = "#282c35",
				-- Color = "#ffffff",
			},
			hsb = {
				hue = 1.0,
				saturation = 1,
				brightness = 0.45,
			},
			width = "100%",
			height = "100%",
			opacity = 0.45,
		},
	},
	-- window_padding = {
	-- 	left = 0,
	-- 	right = 0,
	-- 	top = 0,
	-- 	bottom = 0,
	-- },
}

-- my coolnight colorscheme:
-- and finally, return the configuration to wezterm
return config
