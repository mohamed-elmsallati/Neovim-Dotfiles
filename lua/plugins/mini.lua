return {
	"echasnovski/mini.nvim",
	config = function()
		-- 1. Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })

		-- 2. Add/delete/replace surroundings
		require("mini.surround").setup()

		-- 3. Indent Scope (No animation to prevent cursor jumps)
		require("mini.indentscope").setup({
			symbol = "│",
			options = { try_as_border = true },
			draw = {
				delay = 100, -- Small delay (in ms) before showing to prevent flicker
				animation = require("mini.indentscope").gen_animation.exponential({
					duration = 200, -- Animation speed in ms
					unit = "total", -- 'total' duration or 'step' per line
				}),
			},
		})
		-- Then re-enable it ONLY for specific filetypes if needed,
		-- or just use the following to target the dashboard:
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "snacks_dashboard" then
					vim.b.miniindentscope_disable = true
				end
			end,
		})

		-- 4. Animate (Fixed timing functions)
		local animate = require("mini.animate")
		animate.setup({
			cursor = {
				enable = true,
				timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
			},
			scroll = {
				enable = true,
				-- 'quadratic' is a smooth, reliable curve for scrolling
				timing = animate.gen_timing.quadratic({ duration = 150, unit = "total" }),
			},
			resize = { enable = false },
			open = { enable = false },
			close = { enable = false },
		})
	end,
}
