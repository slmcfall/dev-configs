return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    local function change_nvim_tree_dir()
      local nvim_tree = require("nvim-tree")
      nvim_tree.change_dir(vim.fn.getcwd())
    end

    local function go_right()
      vim.cmd("wincmd l") -- move to closest open buffer
    end

    auto_session.setup({
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      post_restore_cmds = { change_nvim_tree_dir, "NvimTreeOpen", go_right },
      pre_save_cmds = { "NvimTreeClose" },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
    keymap.set("n", "<leader>qq", "<cmd>SessionSave<CR><cmd>wqa<CR>",
      { desc = "Save session, save and close all buffers" })                                                   -- save workspace session for current working directory
  end,
}
