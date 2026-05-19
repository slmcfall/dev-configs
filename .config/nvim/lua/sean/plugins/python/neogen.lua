return {
  "danymat/neogen",
  version = "*",
  enable = true,
  config = function()
    local neogen = require("neogen")

    neogen.setup({
      enabled = true,
    })

    vim.keymap.set("n", "<Leader>ld", function() require("neogen").generate() end, { noremap = true, silent = true })
  end,
}
