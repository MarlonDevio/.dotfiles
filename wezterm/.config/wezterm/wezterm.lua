-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	-- color_scheme = 'termnial.sexy',
	font_shaper = "Harfbuzz",
	freetype_load_target = "Light",
	audible_bell = "Disabled",

	-- font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }),

	font_size = 16,
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
		top = 0,
		bottom = 0,
		-- top = "0.1cell",
		-- bottom = "0cell",
		-- bottom = "-10cell",
	},
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
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,

	front_end = "WebGpu",
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,
	automatically_reload_config = true,
	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 0.80,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
}

return config
-- config = {
-- 	freetype_interpreter_version = 40,
-- 	enable_tab_bar = false,
-- 	window_decorations = "RESIZE",
-- 	window_close_confirmation = "NeverPrompt",
-- 	window_background_opacity = 0.70,
-- 	macos_window_background_blur = 67,
--
-- 	background = {
-- 		{
-- 			source = {
-- 				-- File = "/Users/marlon/Pictures/wallpaper/1-10881_mac-os-mojave-wallpaper-4k.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/cube-blocks.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/cube-blocks.jpg",
-- 				-- File = "/Users/marlon/Pictures/owl.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/broken-glass-pieces-red-4k-at.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/abstract-purple.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/metallic-pink.png",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/broken-glass-pieces-red-4k-at.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/glass-blurred.jpg",
-- 				-- File = "/Users/marlon/Pictures/wallpaper/blurred-colours.jpg",
-- 				-- File = "/Users/marlon/Downloads/arch_fill.png",
-- 				File = "/Users/marlon/Downloads/arch_outline.png",
-- 			},
-- 			hsb = {
-- 				hue = 1.0,
-- 				saturation = 1.02,
-- 				brightness = 0.95,
-- 			},
-- 			width = "100%",
-- 			height = "100%",
-- 			opacity = 0.02,
-- 		},
-- 		{
-- 			source = {
-- 				Color = "#06103f",
-- 				-- Color = "#282c35",
-- 			},
-- 			hsb = {
-- 				hue = 0.90,
-- 				saturation = 1,
-- 				brightness = 0.99,
-- 			},
-- 			width = "100%",
-- 			height = "100%",
-- 			-- opacity = 0.1,
-- 			opacity = 0.55,
-- 		},
-- 		-- k
-- 		-- 	source = {
-- 		-- 		Color = "#282c35",
-- 		-- 	},
-- 		-- 	hsb = {
-- 		-- 		hue = 1.0,
-- 		-- 		saturation = 1,
-- 		-- 		brightness = 0.90,
-- 		-- 	},
-- 		-- 	width = "100%",
-- 		-- 	height = "100%",
-- 		-- 	-- opacity = 0.1,
-- 		-- 	opacity = 0.25,
-- 		-- },
-- 	},
-- 	-- window_padding = {
-- 	-- 	left = 0,
-- 	-- 	right = 0,
-- 	-- 	top = 0,
-- 	-- 	bottom = 0,
-- 	-- },
-- }
--
-- -- my coolnight colorscheme:
-- -- and finally, return the configuration to wezterm
-- return config
