return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
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

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_a = { '' },
        lualine_b = { 'searchcount' },
        -- lualine_c = { 'selectioncount' },
        lualine_c = { "require'weather.lualine'.default_f()" },
        lualine_x = { '' },
        lualine_y = { "require'weather.lualine'.default_f()" },
        lualine_z = { "require'weather.lualine'.default_f()" }
      },
      inactive_sections = {
        -- lualine_a = { '' },
        -- lualine_b = { '' },
        -- lualine_c = { '' },
        -- lualine_x = { '' },
        -- lualine_y = { '' },
        -- lualine_z = { '' }
      },
      tabline = {
        lualine_x = {
          {
            venv,
            color = { fg = "#e0af68" },
          },
          -- { "fileformat" },
          { "filetype" },
        },
        lualine_y = { 'branch', 'diff', 'diagnostics' },
        lualine_z = { 'mode' }
      },
    })
  end,
}
