return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- 1. Force the UI to stay transparent
		local hl_groups = { "TabLineFill", "StatusLine", "StatusLineNC", "TabLine" }
		for _, hl in ipairs(hl_groups) do
			vim.api.nvim_set_hl(0, hl, { bg = "none", fg = "none" })
		end

		-- 2. Theme modification logic (keeping your current safe load)
		-- 2. Theme modification logic
		local status, tokyonight = pcall(require, "lualine.themes.tokyonight")
		if status and type(tokyonight) == "table" then
			local modes = { "normal", "insert", "visual", "replace", "command" }
			for _, mode in ipairs(modes) do
				-- 1. Keep transparency fix
				if tokyonight[mode] and tokyonight[mode].c then
					tokyonight[mode].c.bg = "none"
				end
			end
		else
			tokyonight = "tokyonight"
		end

		require("lualine").setup({
			options = {
				theme = tokyonight,
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			tabline = {
				lualine_a = {
					{
						"mode",
						separator = { right = "" },
						padding = { left = 2, right = 1 },
						color = { gui = "bold" },
					},
				},
				lualine_b = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly, modified)
						newfile_status = false, -- Display new file status
						path = 0, -- 0: Just the filename
						symbols = {
							modified = " 󰫢", -- Use a Nerd Font circle
							readonly = " 󰌾", -- Use a lock icon
							unnamed = " ", -- Use an empty file icon
							newfile = " 󰝒", -- Use a "plus" file icon
						},
						color = { bg = "#f7768e", fg = "#1a1b26", gui = "bold" },
						separator = { right = "" },
						padding = { left = 2, right = 1 },
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "󰊢",
						color = { bg = "#24283b", fg = "#e0af68" },
						separator = { right = "" },
					},
					{
						"diff",
						symbols = {
							added = "󰫢 ",
							modified = "󰫣 ",
							removed = "󰯙 ",
						},
						color = { bg = "#24283b" }, -- Matches the branch background
						separator = { right = "" },
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.deleted,
								}
							end
						end,
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						"diagnostics",
						color = { bg = "#24283b" },
						separator = { left = "" },
						padding = { left = 1, right = 2 },
					},
				},
				lualine_z = {
					{
						"location",
						color = { gui = "bold" },
						separator = { left = "" },
						padding = { left = 1, right = 2 },
					},
				},
			},
			sections = {
				-- Modicator reads this invisible section to change cursor color
				lualine_a = {
					{ "mode", color = { bg = "none", fg = "#1a1b26" } },
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})

		-- 3. The "Ghost" Statusline settings
		vim.opt.laststatus = 3
		vim.opt.showtabline = 2

		-- Final override to make sure the bottom bar stays invisible
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "NONE", blend = 100 })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "NONE", blend = 100 })
	end,
}
