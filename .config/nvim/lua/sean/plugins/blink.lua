return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = {
    -- "garymjr/nvim-snippets",
    -- "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets", -- useful snippets
    -- "onsails/lspkind.nvim",         -- vs-code like pictograms
    -- "saadparwaiz1/cmp_luasnip",           -- for autocompletion
    -- "hrsh7th/cmp-buffer",      -- source for text in buffer
    -- "hrsh7th/cmp-path",        -- source for file system paths
    -- "SergioRibera/cmp-dotenv", -- environment variables
    -- "lukas-reineke/cmp-under-comparator", -- sorts __python__ stuff correctly
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  version = 'v0.*',
  opts = {
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      --
      --
      --
      use_nvim_cmp_as_default = true,
    },
    providers = {
      { "blink.cmp.sources.lsp", name = "LSP" },
      {
        "blink.cmp.sources.snippets",
        name = "Snippets",
        score_offset = -3,
        -- similar to https://github.com/garymjr/nvim-snippets
        opts = {
          friendly_snippets = true,
          -- search_paths = { vim.fn.stdpath("config") .. "/lua/sean/plugins/snippets" },
          global_snippets = { "all" },
          extended_filetypes = {},
          ignored_filetypes = {},
        },
      },
      {
        "blink.cmp.sources.path",
        name = "Path",
        score_offset = 3,
        opts = { get_cwd = vim.uv.cwd },
      },
      {
        "blink.cmp.sources.buffer",
        name = "Buffer",
        keyword_length = 3,
        fallback_for = { "LSP" }, -- PENDING https://github.com/Saghen/blink.cmp/issues/122
      },
    },
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
        'bg:BlinkCmpMenu,bg:BlinkCmpMenuBorder,bg:BlinkCmpMenuSelection,Search:None',
        border = 'padded'
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
    kind_icons = {
      Text = "󰦨",
      Method = "󰊕",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰢐",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      Reference = "",
      File = "󰉋",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    },
  },
}
