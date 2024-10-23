return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('hlchunk').setup({
      indent = { enable = true, style = { "#0e2539" } },
      chunk = {
        style = {
          { fg = "#394b70" },
        },
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─",
        },
        enable = true,
        error_sign = true,
        duration = 0,
        delay = 0,
      },
    })
  end
}
