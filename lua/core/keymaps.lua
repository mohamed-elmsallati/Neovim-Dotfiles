vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Set CWD to current file's directory

-- vim.keymap.set("n", "<leader>cd", function()
--   local root = vim.fn.expand("%:p:h")
--   vim.api.nvim_set_current_dir(root)
--   print("Root set to: " .. root)
-- end, { desc = "Change Directory to current file" })

-- Diagnostic Config & Keymaps
vim.keymap.set("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics (Quickfix List)" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set({ "n", "v" }, "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "p", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "load the session for the current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end, { desc = "select a session to load" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "load the last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "stop persistence" })
