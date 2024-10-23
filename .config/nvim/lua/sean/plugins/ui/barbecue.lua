return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "BufWinEnter",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      include_buftypes = { "", "acwrite" },
      show_navic = false,
      show_modified = true,
      symbols = {
        separator = "/",
        modified = "󱥸",
      },
    },
  }
}
