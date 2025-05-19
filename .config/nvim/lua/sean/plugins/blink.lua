return {
  'saghen/blink.cmp',
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
  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
