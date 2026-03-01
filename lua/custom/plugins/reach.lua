return {
  'toppair/reach.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('reach').setup({
      handle = 'auto',
      show_icons = true,
    }) -- Added missing closing parenthesis here

    -- Keymaps go here (after setup)
    vim.keymap.set('n', '<leader>rb', function() require('reach').buffers() end, { desc = '[R]each [B]uffers' })
    vim.keymap.set('n', '<leader>rm', function() require('reach').marks() end, { desc = '[R]each [M]arks' })
    vim.keymap.set('n', '<leader>rt', function() require('reach').tabpages() end, { desc = '[R]each [T]abpages' })
  end,
}
