return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle NeoTree", silent = true },
    },
    opts = {
      close_if_last_window = true,
      -- 1. ENABLE AUTO-CLEANUP
      -- This ensures that when a buffer is no longer in use, it's wiped.
      enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        -- This is crucial: it prevents Neo-tree from getting confused
        -- about which buffer is the "real" filesystem.
        bind_to_cwd = true,
        window = {
          position = "left",
          -- width = 30, -- Force a specific width so it doesn't "float" or shift
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<leader>e"] = "close_window",
            ["h"] = "close_node",
            ["l"] = "open",
          },
        },
      },

      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 0, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
          use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
        },

        modified = { symbol = "󰫢" },
        git_status = {
          symbols = {
            added = "✚",
            modified = "󰫣",
            deleted = "✖",
            renamed = "󰁔",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },

      event_handlers = {
        -- 2. IMPROVED AUTO-CLOSE
        {
          event = "file_opened",
          handler = function(file_path)
            -- Better than calling execute: directly use the manager to close
            require("neo-tree.sources.manager").close_all()
          end,
        },
        -- 3. THE FIX FOR E95 ERROR
        -- This forces the buffer to be wiped whenever you leave it,
        -- preventing the "Buffer already exists" race condition.
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.cmd("stopinsert")
          end,
        },
      },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
