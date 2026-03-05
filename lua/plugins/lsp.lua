return {
	-- main lsp configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- automatically install lsps and related tools to stdpath for neovim
		-- mason must be loaded before its dependents so we need to set it up here.
		-- note: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"whoissethdaniel/mason-tool-installer.nvim",

		-- useful status updates for lsp.
		{ "j-hui/fidget.nvim", opts = {} },

		-- allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("lspattach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- note: remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				--
				-- in this case, we create a function that lets us more easily define mappings specific
				-- for lsp related items. it sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "lsp: " .. desc })
				end

				-- rename the variable under your cursor.
				--  most language servers support renaming across files, etc.
				map("grn", vim.lsp.buf.rename, "[r]e[n]ame")

				-- execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your lsp for this to activate.
				map("gra", vim.lsp.buf.code_action, "[g]oto code [a]ction", { "n", "x" })

				-- warn: this is not goto definition, this is goto declaration.
				--  for example, in c this would take you to the header.
				map("grd", vim.lsp.buf.declaration, "[g]oto [d]eclaration")

				-- the following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    see `:help cursorhold` for information about when this is executed
				--
				-- when you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textdocument/documenthighlight", event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "cursorhold", "cursorholdi" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "cursormoved", "cursormovedi" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("lspdetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- the following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- this may be unwanted, since they displace some of your code
				if client and client:supports_method("textdocument/inlayhint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[t]oggle inlay [h]ints")
				end
			end,
		})

		-- lsp servers and clients are able to communicate to each other what features they support.
		--  by default, neovim doesn't support everything that is in the lsp specification.
		--  when you add blink.cmp, luasnip, etc. neovim now has *more* capabilities.
		--  so, we create new capabilities with blink.cmp, and then broadcast that to the servers.
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- enable the following language servers
		--  feel free to add/remove any lsps that you want here. they will automatically be installed.
		--  see `:help lsp-config` for information about keys and how to configure
		local servers = {
			-- lua_ls = {},
			-- ts_ls = {}, -- Modern name for Typecraft's 'ts_server'
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Formatter for Lua
			-- "prettier", -- Formatter for JS/TS/HTML/CSS
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end

		-- special lua config, as recommended by neovim help docs
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				-- ... keep your existing on_init logic here ...
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Pull in all installed plugins for completion
							-- "${3rd}/luv/library"
						},
					},
				})
			end,
			settings = {
				Lua = { -- Note: Capital 'L' in 'Lua' is standard for lua_ls settings
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields" }, -- Optional: hides annoying 'missing fields' warnings
					},
					telemetry = { enable = false },
				},
			},
		})
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("lua_ls")
	end,
}
