return {
  -- Maintained LSP configuration
  "neovim/nvim-lspconfig",
  -- Notifications and LSP progress messages
  -- https://github.com/j-hui/fidget.nvim
  {
    "j-hui/fidget.nvim",
    opts = {
      override_vim_notify = true,
    },
  },
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- Schema information
  {
    "b0o/SchemaStore.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
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
