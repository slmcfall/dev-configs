return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local which_key = require("which-key")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)


        -- set keybinds
        opts.desc = "Show line diagnostics"
        keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        which_key.add(
          {
            { "<leader>l", group = "lsp", icon = "󰢱" },
            { "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts },
          }
        )

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "g!", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

        if client.supports_method("textDocument/formatting") then
          opts.desc = "Format buffer"
          keymap.set("n", "gz", vim.lsp.buf.format, opts)
          vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    ---------
    -- DBT --
    ---------
    local configs = require('lspconfig.configs')

    if not configs.dbtls then
      configs.dbtls = {
        default_config = {
          root_dir = lspconfig.util.root_pattern('dbt_project.yml'),
          cmd = { 'dbt-language-server', '--stdio' },
          filetypes = { "sql", "yml", "yaml" },
          init_options = {
            pythonInfo = {
              -- TODO: set this to hook into venv-selector (will probably need to use latest venv-selector branch)
              path =
              '/Users/seanmcfall/Library/Caches/pypoetry/virtualenvs/jaffle-shop-duckdb-4CxgYS01-py3.11/bin/python'
            },
            lspMode = 'dbtProject',
            enableSnowflakeSyntaxCheck = false
          }
        },
      }
    end

    lspconfig.dbtls.setup {}



    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["ruff"] = function()
        -- configure ruff server
        lspconfig["ruff"].setup({
          capabilities = capabilities,
          filetypes = { "python" },
        })
      end,

      ["jsonls"] = function()
        -- configure ruff server
        lspconfig["jsonls"].setup({
          capabilities = capabilities,
          filetypes = { "json" },
        })
      end,

      ["pyright"] = function()
        -- configure pyright server
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          filetypes = { "python" },
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },
              },
            },
          },
        })
      end,

      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
