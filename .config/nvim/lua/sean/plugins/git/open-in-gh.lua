-- open the current file/lines/repo on GitHub via snacks.gitbrowse
-- (replaces openingh.nvim, which built shell commands from directory names)
return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>gf", function() Snacks.gitbrowse({ what = "file" }) end, desc = "Open File in Github" },
    { "<leader>gl", function() Snacks.gitbrowse({ what = "file" }) end, mode = { "n", "x" }, desc = "Open Lines in Github" },
    { "<leader>gr", function() Snacks.gitbrowse({ what = "repo" }) end, desc = "Open Repo in Github" },
  },
}
