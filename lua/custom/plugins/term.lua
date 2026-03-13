return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<leader>tf]],
			direction = "float",
			shade_terminals = false,
			-- THIS IS THE AUTO-CLOSE SETTING
			close_on_exit = true,
			-- Automatically insert mode when opening
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			highlights = {
				NormalFloat = {
					guibg = "#1a1b26", -- Tokyo Night Night Background
				},
				FloatBorder = {
					guifg = "#7aa2f7", -- Tokyo Night Blue
					guibg = "#1a1b26",
				},
			},
			float_opts = {
				border = "curved",
				width = function()
					return math.ceil(vim.o.columns * 0.8)
				end,
				height = function()
					return math.ceil(vim.o.lines * 0.8)
				end,
				winblend = 0,
			},
		})

		-- Keymaps for terminal mode
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			-- Map <esc> to exit terminal mode so you can move windows
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			-- Map jk to exit terminal mode (Astro style)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
