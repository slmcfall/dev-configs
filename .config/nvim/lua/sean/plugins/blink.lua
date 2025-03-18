return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  enabled = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "garymjr/nvim-snippets",
    -- "L3MON4D3/LuaSnip",
    -- "onsails/lspkind.nvim",               -- vs-code like pictograms
    -- "saadparwaiz1/cmp_luasnip",           -- for autocompletion
    -- "hrsh7th/cmp-buffer",                 -- source for text in buffer
    -- "hrsh7th/cmp-path",                   -- source for file system paths
    -- "SergioRibera/cmp-dotenv",            -- environment variables
    -- "lukas-reineke/cmp-under-comparator", -- sorts __python__ stuff correctly
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  version = 'v0.5.0',
  opts = {
    keymap = {
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    completion = {
      menu = {
        winhighlight =
        'bg:BlinkCmpMenu,bg:BlinkCmpMenuBorder,bg:BlinkCmpMenuSelection,Search:None',
        border = 'padded',
        scrollbar = false
      },
      documentation = {
        window = {
          min_width = 10,
          max_width = 100,
          max_height = 30,
          border = 'single',
        }
      }
    },
  },
}
