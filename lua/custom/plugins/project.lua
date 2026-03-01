return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			-- This ensures that when you open a file, Neovim switches to the project root
			detection_methods = { "pattern", "lsp" },
			patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "lazy-lock.json" },
		})
	end,
}
