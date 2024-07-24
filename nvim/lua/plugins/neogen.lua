return {
  -- Documentation
  {
    "danymat/neogen",
    opts = {},
    config = function(_, opts)
      local cmd_opts = {
        noremap = true,
        silent = true,
      }
      vim.keymap.set("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", cmd_opts)
      vim.keymap.set("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", cmd_opts)
      require("neogen").setup(opts)
    end,
  },
}
