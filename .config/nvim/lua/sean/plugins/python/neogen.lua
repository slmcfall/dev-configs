return {
  "danymat/neogen",
  version = "*",
  enabled = true,
  cmd = "Neogen",
  keys = {
    { "<Leader>ld", function() require("neogen").generate() end, desc = "Generate docstring" },
  },
  config = function()
    local neogen = require("neogen")

    neogen.setup({
      enabled = true,
    })
  end,
}
