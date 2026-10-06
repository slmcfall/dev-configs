return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main branch does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    -- ensure these language parsers are installed
    require("nvim-treesitter").install({
      "json",
      "toml",
      "yaml",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "vimdoc",
      "regex",
      "ini",
      "sql",
      "python",
      "terraform",
      "jinja",
      "jinja_inline",
    })

    -- dbt models: parse as jinja, with sql injected into the text between tags
    -- (queries live in queries/dbt/*.scm)
    local jinja_parser = vim.api.nvim_get_runtime_file("parser/jinja.so", false)[1]
    if jinja_parser then
      vim.treesitter.language.add("dbt", { path = jinja_parser, symbol_name = "jinja" })
    end

    -- enable syntax highlighting and indentation for any filetype with a parser
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", {}),
      callback = function(ev)
        if ev.match == "sql" and jinja_parser and vim.fs.root(ev.buf, { "dbt_project.yml" }) then
          -- scheduled so it runs after snacks quickfile (BufReadPost) starts the plain sql parser
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) then
              pcall(vim.treesitter.start, ev.buf, "dbt")
            end
          end)
          return
        end
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
