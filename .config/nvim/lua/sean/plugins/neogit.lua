return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local neogit = require("neogit")

    neogit.setup({
      kind = "tab",
      auto_close_console = true,
    })

    -- set keymaps
    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
    vim.keymap.set("n", "<leader>gq", "<cmd>tabclose<CR>", { desc = "Close Neogit" })
  end,
}
