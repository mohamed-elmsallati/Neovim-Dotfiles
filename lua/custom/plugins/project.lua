return {
  "josephschmitt/pj.nvim",
  dependencies = {
    -- "folke/snacks.nvim",
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
    -- "nvim-mini/mini.pick",
  },
  cmd = { "Pj", "PjCd" },
  keys = {
    { "<leader>sp", "<cmd>Pj<cr>", desc = "[L]ist [P]rojects" },
  },
  opts = {
    -- You can switch between pickers anytime by changing the type
    picker = { type = "telescope" }, -- or "snacks", "fzf_lua", "tv", or "mini.pick"
  },
  config = function()
    require("pj").setup({
      behavior = {
        session_manager = "persistence",
        cd_scope = "tab",
      },
    })
  end,
}
