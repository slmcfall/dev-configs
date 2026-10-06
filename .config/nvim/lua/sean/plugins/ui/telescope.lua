return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  -- loaded on first :Telescope / require("telescope"); keymaps are set in init
  cmd = "Telescope",
  init = function()
    --
    -- pickers
    --
    -- set keymaps

    local keymap = vim.keymap -- for conciseness
    -- files
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files in git repo" })
    keymap.set('n', '<leader>fn', function()
      require('telescope.builtin').find_files({
        find_command = { 'fd', vim.fn.expand("<cword>") },
      })
    end, { desc = 'Fuzzy find file name under cursor' })

    -- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branch picker" })
    keymap.set('n', '<leader>gb', function()
      require('telescope.builtin').git_branches({
        git_command = { 'git', 'for-each-ref', '--all', '--sort=-committerdate', 'refs/heads', "--format='%(refname:short)'" },
      })
    end, { desc = 'Git branches (by commit date)' })

    keymap.set("n", "<leader><leader>", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files in git repo" })
    keymap.set('n', '<leader>fb', function()
      require('telescope.builtin').find_files({ default_text = vim.fn.expand('<cword>') })
    end, {})
    -- strings
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>f/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, { desc = "Current buffer fuzzy find" })
    -- utility
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Search vim undotree" })
    -- keymap.set("n", "<leader>fd", "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>",
    --   { desc = "Find dbt models" })
    -- lsp
    keymap.set("n", "<leader>fx", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end)
  end,
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

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
        layout_strategy = "vertical",
        layout_config = {
          -- height = 0.25,
        },
        path_display = filenameFirst,
        pickers = {
          find_files = {
            hidden = true,
          },
        },
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
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {         -- extend mappings
            i = {
              ["<C-g>"] = lga_actions.quote_prompt(),
              -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = lga_actions.to_fuzzy_refine,
            },
          },
        }
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")
    telescope.load_extension("live_grep_args")
  end,
}
