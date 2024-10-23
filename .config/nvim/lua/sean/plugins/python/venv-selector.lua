return {
  "linux-cultist/venv-selector.nvim",
  ft = "python",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  -- lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
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
      settings = {
        options = {
          on_venv_activate_callback = on_venv_activate,
        },
      },
    }
  end,
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
  },
}
