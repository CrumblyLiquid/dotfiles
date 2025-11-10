return {
  {
    -- Schema information
    "b0o/SchemaStore.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = { "json", "yaml" },
    config = function()
      vim.lsp.config["jsonls"] = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }

      vim.lsp.config["yamlls"] = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      }
    end,
  },
}
