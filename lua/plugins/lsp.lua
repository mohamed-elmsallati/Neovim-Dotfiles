return {
  -- main lsp configuration
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim", -- ADD THIS: The bridge for auto-setup
    "whoissethdaniel/mason-tool-installer.nvim",

    -- useful status updates for lsp.
    {
      "linrongbin16/lsp-progress.nvim",
      config = function()
        require("lsp-progress").setup({
          client_format = function(client_name, spinner, series_messages)
            if #series_messages == 0 then
              return nil
            end
            return spinner .. " " .. client_name .. " " .. table.concat(series_messages, ", ")
          end,
          format = function(client_messages)
            if #client_messages > 0 then
              return table.concat(client_messages, " ")
            end
            return "" -- Returns empty string to hide "LSP" in lualine
          end,
        })
      end,
    },
    "saghen/blink.cmp",
  },
  config = function()
    -- ... [keep your existing lspattach autocmd here] ...
    --
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- Helper function to define mappings specifically for LSP items.
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Core LSP Mappings
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("grd", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Document Highlighting logic
        -- Highlights the word under your cursor when it rests there.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          -- Clear highlights when the LSP detaches
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- Inlay Hints toggle
        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- 1. Check for your toggle file
    local enable_extra_tools = vim.fn.filereadable(vim.fn.stdpath("config") .. "/.enable_web_dev") == 1

    -- 2. Tools that are ALWAYS installed for everyone
    local ensure_installed = { "stylua", "lua-language-server" }

    if enable_extra_tools then
      vim.list_extend(ensure_installed, {
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        "emmet-ls",
        "prettier",
      })
    end

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    -- 3. AUTOMATIC SETUP: This handles any server installed via Mason
    require("mason-lspconfig").setup({
      handlers = {
        -- The first entry (without a key) is the default handler
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Specific override for lua_ls
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" }, disable = { "missing-fields" } },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          })
        end,
      },
    })
  end,
}
