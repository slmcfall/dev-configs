return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({
        custom_textobjects = { -- Whole buffer
          s = { '%{%{().-()%}%}' }

        }
      }) -- a(round)i(nner), not AI
      require("mini.surround").setup()
      -- require("mini.operators").setup()
      require("mini.jump2d").setup({
        vim.api.nvim_set_hl(0, 'MiniJump2dSpot', { fg = "#ff757f" }),
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
