return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    -- Better mapping: <leader>e to toggle (common in most configs)
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle NeoTree', silent = true },
  },
  opts = {
    -- Automatically close Neo-tree when a file is opened
    close_if_last_window = true,
    filesystem = {
      -- This is what you asked for: closes the tree after you select a file
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ['<leader>e'] = 'close_window',
          -- Add 'h' and 'l' for better navigation (like Vim keys)
          ['h'] = 'close_node',
          ['l'] = 'open',
        },
      },
    },
    -- Fixing the [+] icon once and for all
    default_component_configs = {
      modified = {
        symbol = "", -- The Nerd Font icon
      },
      git_status = {
        symbols = {
          modified = "󰷥", -- For Git status
        }
      }
    },
    -- Ensure event handlers close the tree
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    },
  },
}
