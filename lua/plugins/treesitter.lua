return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- We leave this empty for now so it doesn't crash on startup
	end,
}
