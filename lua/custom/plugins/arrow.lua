return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    leader_key = ";", -- Recommended to be a single key
    -- removed the buffer_leader_key to disable arrow built in bookmarks
    buffer_leader_key = "m", -- Per Buffer Mappings
    hide_handbook = true,

    full_path_list = { "update_sign" },
    separate_save_and_remove = true,
  },
}
