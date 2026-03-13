return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",

          comments = { italic = false }, -- Disable italics in comments
        },
        on_highlights = function(hl, c)
          local dark_sidebar = "#1a1b26" -- This matches tokyonight-night's base
          hl.ArrowSign = { fg = "none", bg = "none" }
          hl.SignColumn = { bg = dark_sidebar }
          hl.FoldColumn = { bg = dark_sidebar }
          hl.CursorLineSign = { bg = dark_sidebar }
          hl.CursorLineFold = { bg = dark_sidebar }
          hl.CursorLine = { bg = "#29334d" }
          hl.LineNr = { bg = dark_sidebar }
          hl.CursorLineNr = { fg = "#7aa2f7", bg = dark_sidebar, bold = true }

          hl.Cursor = { fg = c.bg, bg = "#7aa2f7" }
          hl.lCursor = { fg = c.bg, bg = "#7aa2f7" }
          hl.CursorIM = { fg = c.bg, bg = "#7aa2f7" }
          hl.TermCursor = { fg = c.bg, bg = "#7aa2f7" }
        end,
      })
      -- others: 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    opts = {
      colors = {
        copy = "#e0af68",
        delete = "#ff757f",
        insert = "#9ece6a",
        replace = "#f7768e",
        visual = "#bb9af7",
      },
      line_opacity = 0.2,
      set_cursorline = false, -- Add this: prevents mode-based cursorline shifts
      set_number = false,
      set_signcolumn = false,
    },
  },
}
