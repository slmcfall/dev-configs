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
      lsp_file_methods = {
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      },
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
        ["<Leader>ev"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<Leader>eh"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },

      },
    })
    -- open
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
  end
}
