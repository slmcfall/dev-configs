return {
  "nvim-lua/plenary.nvim",          -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  "gbprod/substitute.nvim",
  {
    "folke/snacks.nvim",            -- replaces dressing.nvim for vim.ui.input / vim.ui.select
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      picker = { ui_select = true },
    },
  },
}
