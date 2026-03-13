return {
	{
		"chrisgrieser/nvim-origami",
		event = "BufReadPost", -- Load when you open a file
		opts = {
			useLspFoldsWithTreesitterFallback = {
				enabled = true,
				foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
			},
			pauseFoldsOnSearch = true,
			foldtext = {
				enabled = true,
				padding = {
					character = " ",
					width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
					hlgroup = nil,
				},
				lineCount = {
					template = "  %d lines",
					hlgroup = "Comment",
				},
				diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
				gitsignsCount = true, -- requires `gitsigns.nvim`
				disableOnFt = { "snacks_picker_input" }, ---@type string[]
			},
			autoFold = {
				enabled = true,
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			foldKeymaps = {
				setup = true, -- modifies `h`, `l`, `^`, and `$`
				closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
				scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
			},
		},
		config = function(_, opts)
			-- 1. Essential settings for Origami to function
			-- Inside fold.lua config
			vim.o.foldcolumn = "1" -- This creates the second column you want
			vim.opt.fillchars = {
				foldopen = "", -- Icon for open fold
				foldclose = "", -- Icon for closed fold
				fold = " ", -- Fill character for the fold text
				foldsep = " ", -- This removes the vertical line/numbers in the gutter
			}
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			require("origami").setup(opts)

			local purple = "#bb9af7"
			local dark_sidebar = "#1a1b26"

			-- Set icons to purple on the dark background
			vim.api.nvim_set_hl(0, "FoldSignOpen", { fg = purple, bg = dark_sidebar, force = true })
			vim.api.nvim_set_hl(0, "FoldSignClosed", { fg = purple, bg = dark_sidebar, force = true })

			-- This specifically targets the column where %C lives
			vim.api.nvim_set_hl(0, "FoldColumn", { fg = purple, bg = "none", bold = true })

			-- Ensure the 'CursorLine' version of the fold column also uses these colors
			vim.api.nvim_set_hl(0, "CursorLineFold", { fg = purple, bg = "none", bold = true })
			-- Ensure the current line area stays dark
			vim.api.nvim_set_hl(0, "CursorLineFold", { bg = dark_sidebar, force = true })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = dark_sidebar, force = true })
			vim.api.nvim_set_hl(0, "Folded", { bg = "#1a1b26", force = true })
		end,
	},
}
