return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      -- replaces dressing.nvim for vim.ui.input / vim.ui.select
      input = { enabled = true },
      picker = { ui_select = true },
    },
  }
}
