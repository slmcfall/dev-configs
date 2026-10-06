return {
  "mason-org/mason.nvim",
  -- loaded after startup; servers are found via PATH (set in init) before then
  event = "VeryLazy",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
  init = function()
    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
  end,
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      PATH = "skip", -- already prepended in init
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "pyright",
        "lua_ls",
        "ruff",
        "jsonls",
      },
      -- servers are enabled in lua/sean/lsp.lua
      automatic_enable = false,
    })
  end,
}
