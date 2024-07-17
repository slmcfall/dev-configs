return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  enable = false,
  config = function()
    local ibl = require("ibl")

    ibl.setup({
      indent = { char = "" },
      scope = { enabled = true },
    })
  end
}
