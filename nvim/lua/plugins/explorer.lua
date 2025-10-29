return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      { "echasnovski/mini.icons", opts = {} }
    },
    lazy = false,

    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- default_file_explorer = false,
      win_options = {
        signcolumn = "yes",
      }
    },

    keys = {
      {
        "<leader>o",
        function()
          require('oil').toggle_float()
        end,
        desc = "Open parent directory"
      },
    },
  },
}
