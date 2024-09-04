return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local enable_conceal = false -- Hide command text if true

    require("noice").setup({

      messages = { enabled = true, view = "mini" },

      cmdline = {
        view = "cmdline_popup", -- The kind of popup used for :
        format = {
          cmdline = { conceal = enable_conceal, icon = "󰤇" },
          search_down = { conceal = enable_conceal, icon = "" },
          search_up = { conceal = enable_conceal, icon = "" },
          filter = { conceal = enable_conceal },
          lua = { conceal = enable_conceal },
          help = { conceal = enable_conceal },
          input = { conceal = enable_conceal },
        }
      },

      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = false },
        signature = { enabled = true },
        progress = { enabled = false },
        message = { enabled = false },
        smart_move = { enabled = false },
      },
    })
  end
}
