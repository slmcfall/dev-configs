local config = {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)

-- Disable the default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
  pcall(vim.keymap.del, "n", bind)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local keymap = vim.keymap
    local which_key = require("which-key")

    ---[[ Format and autoimport on Save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      callback = function()
        if client:supports_method("textDocument/formatting") then
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
        end
      end,
    })
    ---]]

    -- set keybinds
    --
    vim.api.nvim_buf_create_user_command(ev.buf, "Fmt", function(_)
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    opts.desc = "Show line diagnostics"
    keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", opts)

    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
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
  end,
})

-- Lua {{{
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
vim.lsp.enable("lua_ls")
-- }}}

-- JSON {{{
vim.lsp.config.jsonls = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
-- }}}

-- PYTHON {{{
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' },
        -- autoSearchPaths = true,
        -- useLibraryCodeForTypes = true,
        -- diagnosticMode = 'openFilesOnly',
      },
    },
  },
}
vim.lsp.enable("pyright")

vim.lsp.config.ruff = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
}
vim.lsp.enable("ruff")
-- }}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
  vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if opts.args == "" or opts.args == client.name then
      client:stop(true)
      vim.notify(client.name .. ": stopped")
    end
  end
end, {
  desc = "Stop all LSP clients or a specific client attached to the current buffer.",
  nargs = "?",
  complete = function(_, _, _)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    return client_names
  end,
})

vim.api.nvim_create_user_command("LspRestart", function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop(true)
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  if not timer then
    return vim.notify("Servers are stopped but havent been restarted")
  end
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start(client[1].config, { attach = false })
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ": restarted")
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
  desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("silent checkhealth vim.lsp")
end, {
  desc = "Get all the information about all LSP attached",
})
-- }}}
