return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    icons = {
      separator = "󰇘"
    },
    sort = { "group", "local", "order", "alphanum", "mod", "lower", "icase" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      ------------
      -- GROUPS --
      ------------
      { "<leader>m", group = "+markdown" },
      { "<leader>e", group = "+file explorer | Nvim-Tree", icon = "󰙅" },
      { "<leader>f", group = "+fuzzy find    | Telescope", icon = "" },
      { "<leader>g", group = "+git           | Neogit", icon = "" },
      { "<leader>d", group = "+dbt", icon = "󰆼" },
      { "<leader>dr", group = "+dbt run ...", icon = "󰆼" },
      { "<leader>dt", group = "+dbt test ...", icon = "󰆼" },
      { "<leader>s", group = "+splits", icon = "" },
      { "<leader>w", group = "+session       | Auto-Session" },
      { "<leader>q", group = "+session       | Auto-Session", hidden = true },


      -------------
      -- KEYMAPS --
      -------------

      -------------
      -- general --
      -------------

      -- clear search highlights
      { "<leader>h", ":nohl<CR>", desc = "Clear search highlights", icon = "󰸱" },

      -- empty line insertions in normal model
      { "<leader><S-o>", "<S-o><ESC>", desc = "Empty line above", hidden = true },
      { "<leader>o", "o<ESC>", desc = "Empty line below", hidden = true },
      -- number incrementation
      { "<leader>+", "<C-a>", desc = "Increment number", hidden = true },
      { "<leader>-", "<C-x>", desc = "Decrement number", hidden = true },
      -- put most recent yank
      { "<leader>p", '"0p', desc = "put most recent yank", icon = "󰆒" },

      ----------------
      -- formatting --
      ----------------
      { "<leader>v", group = "Virtual Environment", icon = "󱔎" },
    })
  end,
}
