return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  -- dependencies = { "echasnovski/mini.icons" },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    local oil = require("oil")

    oil.setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      win_options = {
        wrap = true,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["vv"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["hh"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },

      },
    })
    -- open
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
  end
}
