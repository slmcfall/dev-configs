return {
  "neovim/nvim-lspconfig", -- provides default server configs in lsp/*.lua for vim.lsp.config
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
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
        keymap.set("n", "gl", function() vim.diagnostic.open_float({ scope = "line" }) end, opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
        keymap.set("n", "gD", function()
          vim.cmd("vsplit")
          vim.lsp.buf.declaration()
        end, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        which_key.add(
          {
            { "<leader>l", group = "lsp", icon = "󰢱" },
            { "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", buffer = ev.buf, desc = opts.desc },
          }
        )

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        -- nowait: don't wait for nvim's default gr* LSP mappings (grn, gra, grr, gri, grt)
        keymap.set("n", "gr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { nowait = true })) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "g!", "<cmd>lsp restart<CR>", opts) -- mapping to restart lsp if necessary

        if client and client:supports_method("textDocument/formatting") then
          opts.desc = "Format buffer"
          -- general formatter
          vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local severity = vim.diagnostic.severity
    vim.diagnostic.config({
      signs = {
        text = {
          [severity.ERROR] = " ",
          [severity.WARN] = " ",
          [severity.HINT] = "󰠠 ",
          [severity.INFO] = " ",
        },
      },
    })

    -- completion capabilities are added to every server by blink.cmp (vim.lsp.config("*"))

    ---------
    -- DBT --
    ---------
    vim.lsp.config("dbtls", {
      cmd = { "dbt-language-server", "--stdio" },
      filetypes = { "sql", "yaml" },
      root_markers = { "dbt_project.yml" },
      init_options = {
        pythonInfo = {
          -- TODO: set this to hook into venv-selector
          path =
          '/Users/seanmcfall/Library/Caches/pypoetry/virtualenvs/mindoula-data-IMI5OIww-py3.12/bin/python'
        },
        lspMode = 'dbtProject',
        enableSnowflakeSyntaxCheck = false
      },
    })
    vim.lsp.enable("dbtls")

    -- mason-managed servers are enabled automatically by mason-lspconfig (automatic_enable)
    vim.lsp.config("ruff", {
      filetypes = { "python" },
    })

    vim.lsp.config("jsonls", {
      filetypes = { "json" },
    })

    vim.lsp.config("pyright", {
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

    vim.lsp.config("lua_ls", {
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
}
