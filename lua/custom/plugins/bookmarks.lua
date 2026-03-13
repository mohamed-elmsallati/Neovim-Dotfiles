-- Run these commands if you dont want the
-- .../.local/share/nvim/lazy/sqlite.lua/lua/sqlite/assert.lua:79: sqlite.lua: schema defined ~= db schema. Please drop `bookmarks` table first or set ensure to false. message to show
-- 1. Add the project_root column (most likely candidate)
-- sqlite3 ~/.local/share/nvim/bookmarks.db "ALTER TABLE bookmarks ADD COLUMN project_root TEXT;"
--
-- 2. Add the branch column (used for git-aware bookmarks)
-- sqlite3 ~/.local/share/nvim/bookmarks.db "ALTER TABLE bookmarks ADD COLUMN branch TEXT;"
--
-- 3. Add the list_name column (used for multiple bookmark lists)
-- sqlite3 ~/.local/share/nvim/bookmarks.db "ALTER TABLE bookmarks ADD COLUMN list_name TEXT;"

return {
  "heilgar/bookmarks.nvim",
  event = "BufReadPost",
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("bookmarks").setup({
      -- your configuration comes here
      -- or leave empty to use defaults
      default_mappings = true,
      db_path = vim.fn.stdpath("data") .. "/bookmarks.db",

      ensure = false,
    })
    require("telescope").load_extension("bookmarks")
  end,
  cmd = {
    "BookmarkAdd",
    "BookmarkRemove",
    "Bookmarks",
  },
  keys = {
    { "<leader>ba", "<cmd>BookmarkAdd<cr>", desc = "Add Bookmark" },
    { "<leader>br", "<cmd>BookmarkRemove<cr>", desc = "Remove Bookmark" },
    { "<leader>bj", desc = "Jump to Next Bookmark" },
    { "<leader>bk", desc = "Jump to Previous Bookmark" },
    { "<leader>bl", "<cmd>Bookmarks<cr>", desc = "List Bookmarks" },
    { "<leader>bs", desc = "Switch Bookmark List" },
  },
  vim.api.nvim_set_hl(0, "BookmarkHighlight", {
    bg = "#1a1b26",
    underline = false,
  }),
}
