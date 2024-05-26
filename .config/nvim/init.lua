require("sean.core.options")
require("sean.core")
require("sean.lazy")

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = ".sql",
--   command = "set filetype=sql expandtab"
-- })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.sql" },
  command = "set filetype=sql syntax=dbt",
  desc = "Enable custom dbt syntax",
})
