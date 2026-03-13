return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewToggle" },
  keys = {
    {
      "<leader>hA",
      function()
        -- Check if Diffview is open by looking for its tab
        local view = require("diffview.lib").get_current_view()
        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Toggle Git Diffview",
    },
  },
}
