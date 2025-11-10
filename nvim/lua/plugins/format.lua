return {
  -- Autoformat
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@module 'lazy'
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      -- TODO: Set to false when done testing!
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don"t
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.

        local disable_filetypes = { c = true, cpp = true }

        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end

        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang" },
        cpp = { "clang" },
        rust = { "rustfmt" },
        typst = { "typstyle" },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },

        -- You can use "stop_after_first" to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
