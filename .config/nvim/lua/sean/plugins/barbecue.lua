return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_navic = false,
      show_modified = true,
      symbols = {
        separator = "/",
        modified = "󱥸",
      },
      -- modified = function(bufnr) return vim.bo[bufnr].modified end,
    },
  }
}
