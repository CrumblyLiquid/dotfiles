return {
  {
    "catppuccin/nvim",
    lazy = false, -- load during startup
    priority = 1000, -- load first
    config = vim.cmd.colorscheme("cattpuccin-mocha"),
  },
}
