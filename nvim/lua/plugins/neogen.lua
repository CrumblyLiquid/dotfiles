return {
  ---@module 'lazy'
  ---@type LazyPlugin
  {
    --- Create documentation
    "danymat/neogen",
    lazy = true,
    opts = {},
    config = function(_, opts)
      local cmd_opts = {
        noremap = true,
        silent = true,
      }
      vim.keymap.set("n", "<Leader>nf", function()
        require("neogen").generate()
      end, cmd_opts)
      vim.keymap.set("n", "<Leader>nc", function()
        require("neogen").generate({ type = "class" })
      end, cmd_opts)
      require("neogen").setup(opts)
    end,
  },
}
