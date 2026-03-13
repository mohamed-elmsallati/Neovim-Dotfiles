return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    preset = "helix",

    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰬊 ",
      M = "󰬈 ",
      D = " ",
      S = "󰬚 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },

    spec = {
      { "<leader>q", group = "Persistence", icon = { icon = "󰆓 ", color = "purple" }, mode = { "n" } },
      { "<leader>C", group = "Colors", icon = { icon = " ", color = "cyan" }, mode = { "n" } },
      { "<leader>x", group = "Diagnostics", icon = { icon = " ", color = "red" }, mode = { "n" } },
      { "<leader>b", group = "Bookmarks", icon = { icon = " ", color = "yellow" }, mode = { "n" } },
      { "<leader>i", group = "Nerd Font", icon = { icon = "󰹓 ", color = "green" }, mode = { "n" } },
      { "<leader>s", group = "Search", icon = { icon = " ", color = "blue" }, mode = { "n", "v" } },
      { "<leader>c", group = "LSP", icon = { icon = " ", color = "white" }, mode = { "n", "v" } },
      { "<leader>g", group = "Forge", icon = { icon = " ", color = "orange" } },
      { "<leader>;", group = "Winbar Symbols", icon = { icon = "󱡠 ", color = "cyan" } },
      { "<leader>h", group = "Git Hunk", icon = { icon = "󰊢 ", color = "orange" }, mode = { "n", "v" } },
      { "<leader>t", group = "Toggle" },

      { "<leader>qs", icon = { icon = "󰝉 ", color = "green" }, desc = "Re[s]tore Directory" },
      { "<leader>ql", icon = { icon = " ", color = "blue" }, desc = "Restore [L]ast" },
      { "<leader>qS", icon = { icon = "󱥬 ", color = "yellow" }, desc = "Select [S]ession" },
      { "<leader>qd", icon = { icon = "󱫪 ", color = "red" }, desc = "Stop ([D]on't Save)" },

      { "<leader>cw", icon = { icon = " ", color = "cyan" }, desc = "[C]ode [W]orkspace Symbols " },
      { "<leader>ca", icon = { icon = "󱐋 ", color = "yellow" }, desc = "[C]ode [A]ction" },
      { "<leader>cr", icon = { icon = "󰙒 ", color = "green" }, desc = "[C]ode [R]ename" },
      { "<leader>cf", icon = { icon = " ", color = "blue" }, desc = "[C]ode [F]ormat" },
      { "<leader>cs", icon = { icon = " ", color = "orange" }, desc = "[C]ode [S]ymbols " },
      { "<leader>cl", icon = { icon = " ", color = "red" }, desc = "[C]ode [L]ist " },
      { "<leader>p", desc = "[P]ainter Mode", icon = { icon = " ", color = "green" } },
    },
  },
}

--
--                                          █████████████████████████████████
--                                          █              Table             ██
--                                          █                                 █
--                                          █                                 █
-- █    █  █████ █      █      █████     █                                 █
-- █    █  █      █      █      █     █     █                                 █
-- █    █  █      █      █      █     █     █                                 █
-- ██████  ████   █      █      █     █     █                                 █
-- █    █  █      █      █      █     █     █                                 █
-- █    █  █      █      █      █     █     █                                 █
-- █    █  █████ █████ ████  █████     █████████████████████████████████
