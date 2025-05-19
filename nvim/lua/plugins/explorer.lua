return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- default_file_explorer = false,
      win_options = {
        signcolumn = "yes",
      }
    },
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }
    },
    lazy = false,
    keys = {
      {
        "<leader>o",
        function()
          require('oil').toggle_float()
        end,
        desc = "Open parent directory"
      },
      {
        "<leader>fe",
        function()
          require('oil').open_float()
        end,
        desc = "Open Oil browser"
      },
      {
        "<leader>fw",
        function()
          require('oil').close()
        end,
        desc = "Close Oil browser"
      }
    },
  },
}
