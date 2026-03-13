return {
  "folke/snacks.nvim",
  priority = 1000, -- Load this very early
  lazy = false,
  opts = {
    git = { enabled = true },
    picker = { enabled = true },
    dashboard = {
      autocmds = {
        setup = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "snacks_dashboard",
            callback = function()
              vim.b.miniindentscope_disable = true
            end,
          })
        end,
      },
      preset = {
        header = [[
]],

        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "p", desc = "Projects", action = ":Pj" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", action = [[:lua require("persistence").load()]], section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        {
          section = "terminal",
          cmd = "tokyo_logo",
          height = 10,
          width = 150,
          ttl = 0, -- this is to change the logo every 30 minutes
        },

        { section = "terminal", cmd = "colorscript -e 24", height = 5, padding = 1 },

        { section = "keys", gap = 1, padding = 1 },

        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
}
