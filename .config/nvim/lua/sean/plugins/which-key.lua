return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  -- optional = true,
  opts = {
    defaults = {
      ["<leader>t"] = { name = "+tabs" },
      ["<leader>m"] = { name = "+markdown" },
      ["<leader>e"] = { name = "+file explorer | Nvim-Tree" },
      ["<leader>f"] = { name = "+fuzzy find | Telescope" },
      ["<leader>g"] = { name = "+git | Neogit" },
      ["<leader>s"] = { name = "+splits" },
      ["<leader>v"] = { name = "+virtual environment" },
      ["<leader>w"] = { name = "+session | Auto-Session" },
      ["<leader>q"] = { name = "+session | Auto-Session" },
    },
    icons = {
      separator = "󰇘"
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
