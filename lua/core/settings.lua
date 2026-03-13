vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.o.number = true
vim.opt.cpoptions:append("n") -- Forces the number column to stay a fixed width
vim.opt.numberwidth = 4 -- Ensures there is always at least 4 characters of space
vim.o.relativenumber = true

vim.o.mouse = "a"
vim.o.showmode = false
vim.o.laststatus = 3

vim.o.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Save undo history
local swapdir = vim.fn.stdpath("data") .. "/swap//"
if vim.fn.isdirectory(swapdir) == 0 then
  vim.fn.mkdir(swapdir, "p")
end
vim.opt.directory = swapdir

-- Optional: Also move undo files so they don't clutter your folders
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo//"
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "auto:3"

-- Use this function in your statuscolumn to bypass the numeric %C
-- Replace line 36 in settings.lua
vim.opt.statuscolumn = "%s%{%v:virtnum == 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '' : '') : ' ') : ' '%}%= %l "
vim.opt.foldmethod = "expr"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = false
vim.opt.listchars = { trail = "·", nbsp = "␣" }

vim.o.inccommand = "split"
vim.o.cursorline = true
vim.opt.virtualedit = "block,onemore"

vim.o.scrolloff = 10
vim.o.confirm = true

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = "󰋼 " }

vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true, -- Text shows up at the end of the line
  jump = { float = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
  -- This part ensures the icons don't "push" your relative numbers
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  severity_sort = true,
})

vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wayland") == 1 then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
    paste = { ["+"] = "wl-paste", ["*"] = "wl-paste" },
    cache_enabled = 1,
  }
end

vim.api.nvim_set_hl(0, "DashBlue", { fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "DashPurple", { fg = "#bb9af7" })
vim.api.nvim_set_hl(0, "DashRed", { fg = "#f7768e" })

vim.opt.guicursor = {
  "n-v-c:block", -- Normal, Visual, Command-line: Block
  "i-ci-ve:ver25", -- Insert, Control-line, Visual-exc: Vertical bar (pipe)
  "r-cr:hor20", -- Replace: Underline
  "o:hor50", -- Operator-pending: Half-height underline
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- Fix for Kitty cursor shape changing
if vim.env.TERM == "xterm-kitty" then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = vim.api.nvim_create_augroup("KittyCursor", { clear = true }),
    callback = function()
      vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
    end,
  })
end
