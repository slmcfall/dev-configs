return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({
      output_panel = {
        enabled = true,
      },
    })

    local wk = require("which-key")

    local run_record_mode_all = function()
      local neotest = require("neotest")
      neotest.run.run({ extra_args = { "--record-mode=all" } })
    end

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
        "<leader>yff",
        "<cmd>lua require('neotest').run.run()<CR>",
        desc = "Run Closest Function",
        icon = "󰊕"
      },

      {
        "<leader>yfa",
        run_record_mode_all,
        desc = "Run Closest Function | --record-mode=all",
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
