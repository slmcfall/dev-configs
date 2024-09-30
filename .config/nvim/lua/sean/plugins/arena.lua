return {
  "dzfrias/arena.nvim",
  event = "BufWinEnter",
  opts = {
    max_items = 9,
  },
  config = function()
    local wk = require("which-key")
    wk.add({ { "<leader>a", "<cmd>ArenaToggle<CR>", desc = "Arena", icon = "󰓥" }, })
    wk.add({ { "<C-e>", "<cmd>ArenaToggle<CR>", desc = "Arena", icon = "󰓥" }, })
    wk.add({ { "<leader>fe", ":e $DAGSTER_HOME/.env<CR>", desc = "open .env", icon = "󰓥" }, })
  end,
}
