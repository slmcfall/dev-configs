return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.ai").setup({
        custom_textobjects = { -- Whole buffer
          s = { '%{%{().-()%}%}' }

        }
      }) -- a(round)i(nner), not AI
      require("mini.surround").setup({
        custom_surroundings = {
          -- Make `)` insert parts with spaces. `input` pattern stays the same.
          ['r'] = { output = { left = "{{ ref('", right = "') }}" } },
          ['s'] = { output = { left = "{{ source('', '", right = "') }}" } },
        },
      })
      require("mini.operators").setup()
      vim.api.nvim_set_hl(0, 'MiniJump2dSpot', { fg = "#ff757f" })
      require("mini.jump2d").setup({
        mappings = {
          start_jumping = '<C-f>',
        },
      })
      require("mini.jump").setup({
        delay = {
          -- Delay between jump and highlighting all possible jumps
          highlight = 10 ^ 7,
        },
      })
      require("mini.clue").setup({
        triggers = {
          { mode = 'n', keys = 's' },
          { mode = 'x', keys = 's' },
        },
      })
    end,
  },
}
