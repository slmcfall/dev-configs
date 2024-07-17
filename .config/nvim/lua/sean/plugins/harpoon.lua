return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- key binds
    local wk = require("which-key")
    wk.add({ { "<leader>a", function() harpoon:list():add() end, desc = "Add", icon = "⇁" }, })
    wk.add({ { "<leader>c", function() harpoon:list():clear() end, desc = "Clear", icon = "⇁" }, })
    wk.add({ { "<leader>,", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "List", icon = "⇁" }, })

    vim.keymap.set("n", "<C-i>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-o>", function() harpoon:list():next() end)
  end,
}
