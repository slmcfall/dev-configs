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
      },
    })

    -- open
    vim.keymap.set("n", "<leader>eo", "<cmd>Oil<cr>", { desc = "Open Oil" })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

    -- splits
    vim.keymap.set("n", "<leader>ev", function()
      vim.cmd("vsplit | wincmd l")
      require("oil").open()
    end, { desc = "Open Oil in vertical split" })
    vim.keymap.set("n", "<leader>ex", function()
      vim.cmd("split | wincmd l")
      require("oil").open()
    end, { desc = "Open Oil in horiztonal split" })
  end
}
