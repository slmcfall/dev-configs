return {
  'declancm/windex.nvim',
  config = function()
    require('windex').setup()
    vim.keymap.set({ 'n', 't' }, '<C-t>', "<Cmd>lua require('windex').toggle_terminal()<CR>")
    vim.keymap.set('n', '<Leader>tv', "<Cmd>lua require('windex').create_pane('vertical')<CR>")
    vim.keymap.set('n', '<Leader>ts', "<Cmd>lua require('windex').create_pane('horizontal')<CR>")

    -- get current file path
    -- vim.fn.expand('%:p:.')
    local wk = require("which-key")
    wk.add({ {
      "<C-Bslash>",
      "<Cmd>lua require('windex').create_pane('vertical')<CR>",
      desc = "Toggle terminal",
      icon = "",
      mode = { 'n', 't' }
    }, })
    wk.add({ {
      "<C-_>",
      "<Cmd>lua require('windex').create_pane('horizontal')<CR>",
      desc = "Toggle terminal",
      icon = "",
      mode = { 'n', 't' }
    }, })
  end
}
