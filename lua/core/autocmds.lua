vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    local ft = vim.bo.filetype
    local bt = vim.bo.buftype
    -- If filetype is snacks or the buffer is a special "nofile" (dashboard)
    if ft == "snacks_dashboard" or ft == "" or bt == "nofile" then
      vim.b.miniindentscope_disable = true
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceSavePre",
  callback = function()
    require("neo-tree.command").execute({ action = "close" })
  end,
})
