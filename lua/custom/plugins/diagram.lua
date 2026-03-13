return {
  {
    "jbyuki/venn.nvim",
    config = function()
      function _G.Toggle_Painter()
        local painter_enabled = vim.inspect(vim.b.painter_enabled)
        if painter_enabled == "nil" then
          vim.b.painter_enabled = true
          vim.cmd([[setlocal ve=all]])

          -- █ Solid Painting (HJKL)
          vim.keymap.set("n", "L", "r█l", { buffer = true })
          vim.keymap.set("n", "H", "r█h", { buffer = true })
          vim.keymap.set("n", "J", "r█j", { buffer = true })
          vim.keymap.set("n", "K", "r█k", { buffer = true })

          -- 󰤹 Diagonal Wedges (Physical mapping)
          vim.keymap.set("n", ">", "r", { buffer = true, desc = "Top-Left " })
          vim.keymap.set("n", ":", "r", { buffer = true, desc = "Top-Right " })
          vim.keymap.set("n", '"', "r", { buffer = true, desc = "Bottom-Left " })
          vim.keymap.set("n", "?", "r", { buffer = true, desc = "Bottom-Right " })

          --  Half Blocks (Vertical/Horizontal mid-points)
          vim.keymap.set("n", "i", "r▀", { buffer = true, desc = "▀" })
          vim.keymap.set("n", "m", "r▄", { buffer = true, desc = "▄" })

          --  Eraser
          vim.keymap.set("n", "x", "r <Ignore>", { buffer = true, desc = "Erase" })

          -- 󰼭 Overwrite Typing Mode
          -- Press 't' to type over your drawing without moving blocks
          vim.keymap.set("n", "t", "R", { buffer = true, desc = "Type Over" })

          --   Fill and  Clear (Visual Mode)
          vim.keymap.set("v", "<Tab>", ":VBox<CR>", { buffer = true, desc = "Fill Selection" })
          vim.keymap.set("v", "X", ":VBoxH<CR>", { buffer = true, desc = "Clear Selection" })

          print("   Painter Mode: ON | HJKL: █ | YUBN: Corners     | IM: Half-blocks ▀ ▄ ")
        else
          vim.b.painter_enabled = nil
          vim.cmd([[setlocal ve=]])
          local keys = { "H", "J", "K", "L", ":", '"', "<", ">", "i", "o", "x", "t", "U" }
          for _, key in ipairs(keys) do
            pcall(vim.keymap.del, "n", key, { buffer = true })
          end
          pcall(vim.keymap.del, "v", "<Tab>", { buffer = true })
          pcall(vim.keymap.del, "v", "X", { buffer = true })
          print("   Painter Mode: OFF")
        end
      end

      vim.keymap.set("n", "<leader>p", ":lua Toggle_Painter()<CR>", { desc = "[D]raw [D]iagram Mode" })
    end,
  },
}

--                  ███████████████████████████████████████████████████████████████
--                  █                            █ table                            █
--                  █ sat : IT222[B] 10:30-12:30 █ CS211[B] 12:30-2:30              █
--                  █ sun :                      █                                  █
--                  █ mon : GE331[F] 10:30-12:30 █                                  █
--                  █ tue : SE211[B] 10:30-12:30 █ CN281[C] 12:30-14:30             █
--                  █ wen :                      █                                  █
--                  █ thu :                      █                                  █
--                  █                            █                                  █
--                  ███████████████████████████████████████████████████████████████
