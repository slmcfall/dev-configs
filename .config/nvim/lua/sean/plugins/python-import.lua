return {
  "kiyoon/python-import.nvim",
  ft = "python",
  build = "pipx install . --force",
  keys = {
    {
      "<M-CR>",
      function()
        require("python_import.api").add_import_current_word_and_notify()
      end,
      mode = { "i", "n" },
      silent = true,
      desc = "Add python import",
      ft = "python",
    },
    {
      "<M-CR>",
      function()
        require("python_import.api").add_import_current_selection_and_notify()
      end,
      mode = "x",
      silent = true,
      desc = "Add python import",
      ft = "python",
    },
    {
      "<space>i",
      function()
        require("python_import.api").add_import_current_word_and_move_cursor()
      end,
      mode = "n",
      silent = true,
      desc = "Add python import and move cursor",
      ft = "python",
    },
    {
      "<space>i",
      function()
        require("python_import.api").add_import_current_selection_and_move_cursor()
      end,
      mode = "x",
      silent = true,
      desc = "Add python import and move cursor",
      ft = "python",
    },
    {
      "<space>tr",
      function()
        require("python_import.api").add_rich_traceback()
      end,
      silent = true,
      desc = "Add rich traceback",
      ft = "python",
    },
  },
}
-- "rcarriga/nvim-notify",   -- optional
