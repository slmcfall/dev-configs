return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")
      },
      output_panel = {
        enabled = true,
        open = "botright vsplit | vertical resize 50"
      },
    })

    local wk = require("which-key")

    wk.add({
      { "<leader>y", group = "+tests | Neotest", icon = "󰙨" },

      {
        "<leader>yy",
        "<cmd>lua require('neotest').output_panel.toggle()<CR>",
        desc = "Neotest Toggle Test Window",
      },

      {
        "<leader>yc",
        "<cmd>lua require('neotest').output_panel.clear()<CR>",
        desc = "Clear Test Window",
        icon = "󰤑"
      },

      {
        "<leader>ys",
        "<cmd>lua require('neotest').summary.toggle()<CR>",
        desc = "Toggle Summary Window",
      },

      {
        "<leader>yf",
        "<cmd>lua require('neotest').run.run()<CR>",
        desc = "Run Closest Function",
        icon = "󰊕"
      },

      {
        "<leader>yb",
        "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
        desc = "Run Current Buffer",
        icon = ""
      }
    })
  end
}
