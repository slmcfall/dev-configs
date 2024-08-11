return {
  'declancm/windex.nvim',
  config = function()
    require('windex').setup({ default_keymaps = false, save_buffers = false })
    vim.keymap.set({ 'n', 't' }, '<C-t>', "<Cmd>lua require('windex').toggle_terminal()<CR>")
    vim.keymap.set('t', '<C-n>', '<C-Bslash><C-n>')
    --
    -- terminal splits
    -- vim.keymap.set({ 'n', 't' }, '<C-Bslash>', "<Cmd>lua require('windex').create_pane('vertical')<CR>")
    vim.keymap.set({ 'n', 't' }, '<C-_>', "<Cmd>lua require('windex').create_pane('horizontal')<CR>")

    --
    -- custom terminal command launchers
    --
    local wk = require("which-key")
    local function windex_terminal_command(mode, cli_command)
      local tog_term = "<Cmd>lua require('windex').toggle_terminal('%s', '%s')<CR>"
      return string.format(tog_term, mode, cli_command)
    end

    -- local cmd = "dbt run -m" .. vim.fn.expand('') .. "+"
    -- PYTHON
    local cmd = "poetry run pytest " .. vim.fn.expand('%p:.')
    wk.add({ {
      "<leader>ty",
      windex_terminal_command('all', cmd),
      desc = "Run Pytest on currently opened buffer",
      icon = "",
      mode = { 'n' }
    }, })

    -- TMUX
    cmd = "sesh connect $(sesh list | fzf)"
    wk.add({ {
      "<leader>ts",
      windex_terminal_command('all', cmd),
      desc = "Launch Tmux Session Picker",
      icon = "",
      mode = { 'n' }
    }, })
  end
}
