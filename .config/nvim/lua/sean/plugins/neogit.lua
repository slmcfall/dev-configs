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
      kind = "vsplit"
    })

    -- set keymaps
    vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
  end,
}
