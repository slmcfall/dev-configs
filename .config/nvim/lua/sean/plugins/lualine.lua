return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    local colors = {
      blue = "#7aa2f7",
      green = "#41a6b5",
      violet = "#9d7cd8",
      yellow = "#ffc777",
      red = "#FF4A4A",
      red_bg = "#ff757f",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#011728",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      terminal = {
        a = { bg = colors.red_bg, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.inactive_bg, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.inactive_bg },
        c = { bg = colors.inactive_bg, fg = colors.inactive_bg },
      },
    }
    local function get_last_path_part(file_path)
      return file_path:match("([^/]+)$") -- Match any characters except / until the end
    end

    local function venv()
      local venv_get = require('venv-selector').get_active_venv()
      if venv_get == nil or venv_get == '' then
        venv_get = ''
      else
        venv_get = get_last_path_part(venv_get)
      end
      return venv_get
    end

    local function bunny()
      return '󰤇'
    end

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_a = { { 'mode' },
          { bunny }, },
        lualine_b = { 'branch', 'filetype', 'diagnostics' },
        lualine_c = {
          {
            venv,
            color = { fg = "#e0af68" },
          },
        },
        lualine_x = { '' },
        lualine_y = { '' },
        lualine_z = { '' }
      },
    })
  end,
}
