return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    -- ensure these language parsers are installed
    require("nvim-treesitter").install({
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "vimdoc",
      "sql",
      "python",
      "terraform",
    })

    -- enable syntax highlighting and indentation for any filetype with a parser
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", {}),
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- incremental selection (built into nvim 0.12 via `an` / `in`)
    vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Start treesitter selection" })
    vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Expand treesitter selection" })
    vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Shrink treesitter selection" })
  end,
}
