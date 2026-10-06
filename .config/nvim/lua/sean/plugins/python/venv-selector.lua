return {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local function on_venv_activate()
      local python_ = require("venv-selector").python()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            python = python_
          })
        },
      })
    end
    require("venv-selector").setup {
      options = {
        on_venv_activate_callback = on_venv_activate,
      },
    }
  end,
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
  },
}
