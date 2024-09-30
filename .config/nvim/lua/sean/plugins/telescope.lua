return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "debugloop/telescope-undo.nvim",
    "olacin/telescope-cc.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopeResults",
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd("TelescopeParent", "\t\t.*$")
          vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
      end,
    })

    local function filenameFirst(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then return tail end
      return string.format("%s\t\t%s", tail, parent)
    end

    telescope.setup({
      defaults = {
        path_display = filenameFirst,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
          },
        },
        preview = {
          hide_on_startup = true -- hide previewer when picker starts
        },
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.75,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")
    telescope.load_extension("dbtpal")
    telescope.load_extension("conventional_commits")


    --
    -- pickers
    --
    local builtin = require('telescope.builtin')
    -- set keymaps

    local keymap = vim.keymap -- for conciseness
    -- files
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files in git repo" })
    -- strings
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Current buffer fuzzy find" })
    -- utility
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>gc", "<cmd>Telescope conventional_commits<cr>", { desc = "Commit w/ conventional commit" })
    keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Search vim undotree" })
    keymap.set("n", "<leader>fd", "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>",
      { desc = "Find dbt models" })
    -- lsp
    keymap.set("n", "<leader>fx", builtin.lsp_dynamic_workspace_symbols)
  end,
}
