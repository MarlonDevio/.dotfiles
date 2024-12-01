-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	freetype_interpreter_version = 40,
	front_end = "WebGpu",
	font_shaper = "Harfbuzz",
	-- freetype_load_target = "Light",

	keys = {
		-- Ctrl+Shift+Left Arrow
		{
			key = "LeftArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendString("\x1b[1;6D"),
		},
		-- Ctrl+Shift+Right Arrow
		{
			key = "RightArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendString("\x1b[1;6C"),
		},
		-- Ctrl+Shift+Up Arrow
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendString("\x1b[1;6A"),
		},
		-- Ctrl+Shift+Down Arrow
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendString("\x1b[1;6B"),
		},
	},
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 0.90,
	macos_window_background_blur = 67,

	-- font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }),

	font_size = 18,
	color_scheme = "nordfox",
	default_cursor_style = "BlinkingBar",

	font = wezterm.font({ family = "JetBrainsMonoNL Nerd Font", weight = "DemiBold" }),

	font_rules = {
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "Victor Mono",
				weight = "Bold",
				style = "Italic",
			}),
		},
		{
			italic = true,
			intensity = "Half",
			font = wezterm.font({
				family = "Victor Mono",
				weight = "DemiBold",
				style = "Italic",
			}),
		},
		{
			italic = true,
			intensity = "Normal",
			font = wezterm.font({
				family = "Victor Mono",
				style = "Italic",
			}),
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 20,
		bottom = 0,
		-- top = "0.1cell",
		-- bottom = "0cell",
		-- bottom = "-10cell",
	},
	background = {
		{
			source = {
				-- File = "/Users/marlon/Pictures/wallpaper/1-10881_mac-os-mojave-wallpaper-4k.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/cube-blocks.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/cube-blocks.jpg",
				-- File = "/Users/marlon/Pictures/owl.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/broken-glass-pieces-red-4k-at.jpg",
				-- File = "/Users/marlon/Pictures/wallpaper/abstract-purple.jpg",
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
			opacity = 0.30,
		},
		{
			source = {
				Color = "#06103f",
				-- Color = "#282c35",
			},
			hsb = {
				hue = 1.0,
				saturation = 1,
				brightness = 0.90,
			},
			width = "100%",
			height = "100%",
			-- opacity = 0.1,
			opacity = 0.35,
		},
		{
			source = {
				Color = "#282c35",
			},
			hsb = {
				hue = 1.0,
				saturation = 1,
				brightness = 0.90,
			},
			width = "100%",
			height = "100%",
			-- opacity = 0.1,
			opacity = 0.85,
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
