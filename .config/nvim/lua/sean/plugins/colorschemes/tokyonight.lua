return { -- neomodern
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local colors = {
        bg = "#011628",
        bg_dark = "#011423",
        bg_highlight = "#143652",
        bg_search = "#0A64AC",
        bg_visual = "#275378",
        fg = "#CBE0F0",
        fg_dark = "#B4D0E9",
        fg_gutter = "#627E97",
        border = "#385165",
      }

      require("tokyonight").setup({
        style = "night",
        dim_inactive = true,
        cache = true,
        on_colors = function(c)
          c.bg = colors.bg
          c.bg_dark = colors.bg_dark
          c.bg_float = colors.bg_dark
          c.bg_highlight = colors.bg_highlight
          c.bg_popup = colors.bg_dark
          c.bg_search = colors.bg_search
          c.bg_sidebar = colors.bg_dark
          c.bg_statusline = colors.bg_dark
          c.bg_visual = colors.bg_visual
          c.border = colors.border
          c.fg = colors.fg
          c.fg_dark = colors.fg_dark
          c.fg_float = colors.fg
          c.fg_gutter = colors.fg_gutter
          c.fg_sidebar = colors.fg_dark
        end,
      })

      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
