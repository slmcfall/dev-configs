return
{
  "cdmill/neomodern.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neomodern").setup({
      -- optional configuration here
      style = "iceclimber",
    })
    -- require("neomodern").load()
  end,
}
