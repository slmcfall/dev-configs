return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
    -- -- "saadparwaiz1/cmp_luasnip",           -- for autocompletion
    -- "hrsh7th/cmp-buffer",      -- source for text in buffer
    -- "hrsh7th/cmp-path",        -- source for file system paths
    -- "SergioRibera/cmp-dotenv", -- environment variables
    -- "lukas-reineke/cmp-under-comparator", -- sorts __python__ stuff correctly
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  version = 'v0.*',
  opts = {
    keymap = {
      accept = '<CR>',
      show_documentation = '<C-p>',
      hide_documentation = '<C-p>',
      select_next = '<C-j>',
      select_prev = '<C-k>',
      snippet_forward = '<Tab>',
      snippet_backward = '<S-Tab>',
    },
    windows = {
      autocomplete = {
        winhighlight =
        'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorColumn:BlinkCmpMenu,Search:BlinkCmpMenuBorder'
      },
      documentation = {
        min_width = 10,
        max_width = 100,
        max_height = 30,
        border = 'single',
      }
    },
    nerd_font_variant = 'mono',
    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },
    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
  },
}
