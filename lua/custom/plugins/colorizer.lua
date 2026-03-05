return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	-- Using 'opts' instead of 'config'
	opts = {
		filetypes = { "*" },
		buftypes = {},
		user_commands = true,
		lazy_load = false,
		parsers = {
			css = false,
			hex = {
				rgb = true,
				rgba = true,
				rrggbb = true,
				rrggbbaa = true,
			},
			rgb = { enable = true },
			hsl = { enable = true },
			oklch = { enable = true },
		},
		display = {
			mode = "foreground",
			virtualtext = {
				char = "",
				position = "after", -- This puts it next to your comments
				hl_mode = "foreground",
			},
		},
	},
}
