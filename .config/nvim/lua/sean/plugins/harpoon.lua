return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -----------------
    --- TELESCOPE ---
    -----------------
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title =
        "SOLID OF SCALE YOU MIGHT BE FOUL DRAGON, BUT I WILL RIDDLE WITH HOLES YOUR ROTTEN HIDE!!! WITH A HAIL OF HARPOONS!!!",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        -- previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })

    -- key binds
    local wk = require("which-key")
    wk.add({ { "<leader>a", function() harpoon:list():add() end, desc = "Add", icon = "⇁" }, })
    wk.add({ { "<leader>c", function() harpoon:list():clear() end, desc = "Clear", icon = "⇁" }, })

    vim.keymap.set("n", "<C-i>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-o>", function() harpoon:list():next() end)
  end,
}
