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
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        "<leader>ft",
        function()
          vim.g.format_on_save = not vim.g.format_on_save
          local state = vim.g.format_on_save and "enabled" or "disabled"
          require("fidget").notify("Format on save: " .. state)
        end,
        desc = "Toggle format on save",
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      -- TODO: Set to false when done testing!
      notify_on_error = true,
      format_on_save = function(bufnr)
        if not vim.g.format_on_save then
          return nil
        end
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang" },
        cpp = { "clang" },
        rust = { "rustfmt" },
        typst = { "typstyle" },
        -- You can use "stop_after_first" to run the first available formatter from the list
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    init = function()
      vim.g.format_on_save = true
    end,
  },
}
