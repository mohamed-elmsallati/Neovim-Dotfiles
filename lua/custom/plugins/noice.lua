return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    popupmenu = {
      enabled = false, -- Disables Noice popup menu so ui.nvim can take over
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup", -- This is the clean floating one
    },
    messages = {
      enabled = true, -- Let Noice handle messages and notifications
    },
    lsp = {
      progress = {
        enabled = false, -- This is the cleanest way to kill that specific popup
      },
    },
    -- add any options here
  },

  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
