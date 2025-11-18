---@module 'lazy'
---@type LazyPlugin[]
return {
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@module 'todo-comments'
    ---@type TodoOptions
    opts = {
      signs = false,
    },
  },
  {
    --- Create documentation
    "danymat/neogen",
    lazy = true,
    opts = {
      snippet_engine = "luasnip",
    },
    config = function(_, opts)
      require("neogen").setup(opts)

      local cmd_opts = {
        noremap = true,
        silent = true,
      }
      vim.keymap.set("n", "<leader>nf", function()
        require("neogen").generate({ type = "func" })
      end, cmd_opts)
      vim.keymap.set("n", "<leader>nc", function()
        require("neogen").generate({ type = "class" })
      end, cmd_opts)
    end,
  },
}
