return {
  "PedramNavid/dbtpal",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ft = {
    "sql",
  },
  commit = "d3e879d",
  config = function()
    require("dbtpal").setup({
      path_to_dbt = "dbt",
      path_to_dbt_project = "",
      path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),
      extended_path_search = true,
      protect_compiled_files = true,
      custom_dbt_syntax_enabled = false,
    })
    local wk = require("which-key")
    wk.add({ { "<leader>drm", "<cmd>DbtRun<cr>", desc = "+run model     | dbt", icon = "󰆼" }, })
    wk.add({ { "<leader>drp", "<cmd>DbtRunAll<cr>", desc = "+run all models| dbt", icon = "󰆼" }, })
    wk.add({ { "<leader>dtm", "<cmd>DbtTest<cr>", desc = "+run test      | dbt", icon = "󰆼" }, })
  end,
}
