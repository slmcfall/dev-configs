return {
  "PedramNavid/dbtpal",
  -- enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ft = {
    "sql",
    "yaml",
  },
  keys = {
    { "<leader>drf", "<cmd>DbtRun<cr>" },
    { "<leader>drp", "<cmd>DbtRunAll<cr>" },
    { "<leader>dtf", "<cmd>DbtTest<cr>" },
    { "<leader>dm",  "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>" },
  },
  config = function()
    require("dbtpal").setup({
      path_to_dbt = "/Users/seanmcfall/Library/Caches/pypoetry/virtualenvs/tutorial-dbt-dagster-vp4dBQxB-py3.12/bin/dbt",
      path_to_dbt_project = "",
      path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),
      extended_path_search = true,
      protect_compiled_files = true,
    })
    require("telescope").load_extension("dbtpal")
  end,
}
