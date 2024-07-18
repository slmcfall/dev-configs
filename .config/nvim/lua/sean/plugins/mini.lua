return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.clue").setup({
        triggers = {
          { mode = 'n', keys = 's' },
          { mode = 'x', keys = 's' },
        },
      })
    end,
  },
}
