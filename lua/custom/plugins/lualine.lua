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
				-- 1. Keep your transparency fix
				if tokyonight[mode] and tokyonight[mode].c then
					tokyonight[mode].c.bg = "none"
				end

				-- 2. NEW: Force Section A (Mode) to be bold
				if tokyonight[mode] and tokyonight[mode].a then
					tokyonight[mode].a.gui = "bold"
				end

				if tokyonight[mode] and tokyonight[mode].b then
					tokyonight[mode].b.gui = "bold"
				end
				-- 3. NEW: Force Section Z (Location) to be bold
				if tokyonight[mode] and tokyonight[mode].z then
					tokyonight[mode].z.gui = "bold"
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
					{ "mode", separator = { right = "" }, padding = { left = 2, right = 1 }, gui = "bold" },
				},
				lualine_b = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly, modified)
						newfile_status = false, -- Display new file status
						path = 0, -- 0: Just the filename
						symbols = {
							modified = " ", -- Use a Nerd Font circle
							readonly = " 󰌾", -- Use a lock icon
							unnamed = " ", -- Use an empty file icon
							newfile = " 󰝒", -- Use a "plus" file icon
						},
						color = { bg = "#f7768e", fg = "#1a1b26", gui = "bold" },
						separator = { right = "" },
						padding = { left = 2, right = 1 },
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					{
						"diagnostics",
						gui = "bold",
						color = { bg = "#24283b" },
						separator = { left = "" },
						padding = { left = 1, right = 2 },
					},
				},
				lualine_z = {
					{ "location", separator = { left = "" }, padding = { left = 1, right = 2 } },
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
