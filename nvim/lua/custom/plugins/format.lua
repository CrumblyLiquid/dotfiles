return {
  -- Autoformat
  {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>ff",
        mode = "",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "[F] Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
