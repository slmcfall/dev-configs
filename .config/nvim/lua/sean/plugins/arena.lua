return {
  "dzfrias/arena.nvim",
  event = "BufWinEnter",
  config = function()
    local wk = require("which-key")
    wk.add({ { "<leader>a", "<cmd>ArenaToggle<CR>", desc = "Arena", icon = "󰓥" }, })
  end,
}
