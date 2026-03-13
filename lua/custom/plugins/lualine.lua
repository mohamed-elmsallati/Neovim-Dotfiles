return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 1. Force the UI to stay transparent
    local hl_groups = { "TabLineFill", "StatusLine", "StatusLineNC", "TabLine" }
    for _, hl in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, hl, { bg = "none", fg = "none" })
    end

    -- 2. Theme modification logic
    local status, tokyonight = pcall(require, "lualine.themes.tokyonight")
    if status and type(tokyonight) == "table" then
      local modes = { "normal", "insert", "visual", "replace", "command" }
      for _, mode in ipairs(modes) do
        if tokyonight[mode] and tokyonight[mode].c then
          tokyonight[mode].c.bg = "none"
        end
      end
    else
      tokyonight = "tokyonight"
    end

    local function arrow_status()
      local ok, arrow = pcall(require, "arrow.statusline")
      if not ok then
        return ""
      end
      return arrow.text_for_statusline_with_icons()
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
            fmt = function(name)
              local ft = vim.bo.filetype
              local bt = vim.bo.buftype

              if ft == "TelescopePrompt" or ft == "snacks_picker_input" then
                return " Telescope"
              end

              if ft == "trouble" or ft == "qf" then
                return " Diagnostics"
              end

              if ft == "neo-tree" then
                return "󰙅 Explorer"
              end
              if ft == "snacks_dashboard" then
                return "󰕮 Dashboard"
              end

              if ft == "VoltWindow" then
                return " Color Utils "
              end

              -- Group the conditions so they ALL must be true for the empty-name case
              if (ft == "" or name == "") and bt == "nofile" and not vim.bo.modifiable then
                return "󱡁 Arrows"
              end

              local is_unnamed = (name == "" or name == "[No Name]" or name:match(""))
              local is_new = (vim.bo.filetype == "")
              local ok, devicons = pcall(require, "nvim-web-devicons")

              if ok and not is_unnamed and not is_new then
                local icon = devicons.get_icon(name, vim.fn.expand("%:e"), { default = true })
                return icon .. " " .. name
              end

              return name
            end,
            file_status = true,
            path = 0,
            symbols = {
              modified = "󰫢 ",
              readonly = "󰌾",
              unnamed = " ",
              newfile = " ",
            },
            color = function()
              if vim.bo.filetype == "trouble" then
                return { bg = "#f7768e", fg = "#1a1b26", gui = "bold" } -- Red for Trouble
              end

              return { bg = "#b99ff1", fg = "#1a1b26", gui = "bold" } -- Your standard Purple
            end,
            padding = { left = 1, right = 1 },
            separator = { right = "" },
          },
          {
            arrow_status,
            color = { bg = "#b99ff1", fg = "#1a1b26", gui = "bold" },
            separator = { right = "" },
            padding = { left = 0, right = 1 },
            cond = function()
              -- Only show if the current file is actually bookmarked
              local ok, arrow = pcall(require, "arrow.statusline")
              return ok and arrow.is_on_arrow_file() ~= nil
            end,
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
            color = { bg = "#24283b" },
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
        lualine_a = {
          { "mode", color = { bg = "none", fg = "#1a1b26" } },
        },
        lualine_b = {
          {
            "selectioncount",
            color = { fg = "#bb9af7", bg = "#1a1b26", gui = "bold" },
            separator = { right = "" },
          },
          {
            "searchcount",
            color = { fg = "#e0af68", bg = "#1a1b26" },
            separator = { right = "" },
          },
        },
        lualine_c = {
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then
                return ""
              end
              return "󰑊 Recording @" .. reg
            end,
            color = { fg = "#f7768e", gui = "bold" },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            function()
              local ok, lsp_progress = pcall(require, "lsp-progress")
              if not ok then
                return ""
              end

              local status = lsp_progress.progress()

              -- If the status is just "LSP", "done", or empty, hide the block
              -- We use string.match to catch variations like " LSP " or "LSP"
              if not status or status == "" or status == "LSP" or status:match("^%s*LSP%s*$") then
                return ""
              end

              return status
            end,
            color = { bg = "#24283b", fg = "#7aa2f7" },
            separator = { left = "" },
            padding = { left = 1, right = 1 },
          },
        },
      },
    })

    vim.opt.laststatus = 3
    vim.opt.showtabline = 2

    -- Final override
    vim.api.nvim_create_augroup("lualine_lsp_progress", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_lsp_progress",
      pattern = "LspProgressStatusUpdated",
      callback = require("lualine").refresh,
    })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "NONE", blend = 100 })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "NONE", blend = 100 })
  end,
}
