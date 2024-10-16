return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = {
    -- "hrsh7th/cmp-buffer",      -- source for text in buffer
    -- "hrsh7th/cmp-path",        -- source for file system paths
    -- "SergioRibera/cmp-dotenv", -- environment variables
    "L3MON4D3/LuaSnip",
    -- -- "saadparwaiz1/cmp_luasnip",           -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
    -- "lukas-reineke/cmp-under-comparator", -- sorts __python__ stuff correctly
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
  },

  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- On musl libc based systems you need to add this flag
  -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
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
    -- keymap = {
    --   -- show = '<C-space>',
    --   -- hide = '<C-e>',
    --   accept = '<CR>',
    --   select_prev = { '<Up>', '<C-p>' },
    --   select_next = { '<Down>', '<C-n>' },
    --
    --   show_documentation = '<C-space>',
    --   hide_documentation = '<C-space>',
    --   scroll_documentation_up = '<C-b>',
    --   scroll_documentation_down = '<C-f>',
    --
    --   snippet_forward = '<Tab>',
    --   snippet_backward = '<S-Tab>',
    -- },
    windows = {
      autocomplete = {
        winhighlight =
        'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorColumn:BlinkCmpMenuSelection,Search:None'
      },
      documentation = {
        min_width = 10,
        max_width = 100,
        max_height = 30,
        border = 'single',
      }
    },
    highlight = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },
  },
}
