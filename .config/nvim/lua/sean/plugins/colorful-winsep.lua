return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinNew" },
  config = function()
    local winsep = require("colorful-winsep")

    winsep.setup({
      -- highlight for Window separator
      -- tokyonights
      hi = {
        bg = "#011423",
        fg = "#143652",
      },
      -- neomodern, iceclimber
      -- hi = {
      --   bg = "#171718",
      --   fg = "#6b6a6e",
      -- },
      -- This plugin will not be activated for filetype in the following table.
      -- no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
      -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      -- Smooth moving switch
      smooth = true,
      exponential_smoothing = true,
      anchor = {
        left = { height = 1, x = -1, y = -1 },
        right = { height = 1, x = -1, y = 0 },
        up = { width = 0, x = -1, y = 0 },
        bottom = { width = 0, x = 1, y = 0 },
      },
    })
  end
}
