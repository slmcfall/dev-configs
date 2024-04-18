return {
  require('nvim-web-devicons').setup {
   -- your personnal icons can go here (to override)
   -- you can specify color or cterm_color instead of specifying both of them
   -- DevIcon will be appended to `name`
   override = {
    toml = {
      icon = "",
      color = "#af5fd7",
      cterm_color = "134",
      name = "toml"
    }
   };
  }
}
