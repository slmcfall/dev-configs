return {
  "danymat/neogen",
  version = "*",
  enable = true,
  config = function()
    local neogen = require("neogen")

    neogen.setup({
      enabled = true,
    })

    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<Leader>ld", ":lua require('neogen').generate()<CR>", opts)
  end,
}
