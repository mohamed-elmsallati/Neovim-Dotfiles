return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",

				comments = { italic = false }, -- Disable italics in comments
			},
		})

		-- others: 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
