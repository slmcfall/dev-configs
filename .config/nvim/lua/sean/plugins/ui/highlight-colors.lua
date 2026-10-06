return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy", -- setup() refreshes all open buffers
  config = function()
    require('nvim-highlight-colors').setup({
      render = 'virtual',
    })
  end
}
