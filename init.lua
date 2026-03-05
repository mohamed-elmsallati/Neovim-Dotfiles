require("core.settings")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	{ "NMAC427/guess-indent.nvim", opts = {} },

	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	require("kickstart.plugins.lint"),
	require("kickstart.plugins.autopairs"),
	require("kickstart.plugins.neo-tree"),
	-- require("kickstart.plugins.gitsigns"),

	{ import = "plugins" },
	{ import = "custom.plugins" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {},
	},
	git = {
		timeout = 600,
	},
})
