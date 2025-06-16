return {
  "almo7aya/openingh.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>gf", "<cmd>OpenInGHFile<cr>", { desc = "Open File in Github" })
    vim.keymap.set("n", "<leader>gl", "<cmd>OpenInGHFileLines<cr>", { desc = "Open Lines in Github" })
    vim.keymap.set("n", "<leader>gr", "<cmd>OpenInGHRepo<CR>", { desc = "Open Repo in Github" })
  end,

}
