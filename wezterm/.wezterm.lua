-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font Settings
config.font = wezterm.font_with_fallback({
	{
		family = "Monaspace Argon Var",
		weight = "Regular",
		harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
	},
	"JetBrains Mono",
	{ family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.font_size = 12.5

-- Theme
config.color_scheme = "Catppuccin Mocha"

return config

