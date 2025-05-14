return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        "mason-org/mason.nvim",
        version = "^1.0.0",
        -- Use system provided binaries first if available
        opts = { PATH = "append" },
        config = true
      },
      {
        "mason-org/mason-lspconfig.nvim",
        version = "^1.0.0",
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Schema information
      "b0o/SchemaStore.nvim",

      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      local servers = {
        bashls = {},
        lua_ls = {},
        -- We're using rustaceanvim so we don't need to do the setup on our own
        -- rust_analyzer = {},
        -- Failing to install
        -- basedpyright = {},
        pyright = {},

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        clangd = {
          init_options = { clangdFileStatus = true },
          filetypes = { "c", "cpp", "h", "hpp" },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {}

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })

      --[[ local lspconfig = require("lspconfig")
      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end ]]

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions,
            { buffer = event.buf, desc = "LSP: [G]oto [D]efinition" })
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
            { buffer = event.buf, desc = "LSP: [G]oto [R]eferences" })
          vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations,
            { buffer = event.buf, desc = "LSP: [G]oto [I]mplementation" })
          -- vim.keymap.set("n", "gD", require("telescope.builtin").lsp_declarations,
          --   { buffer = event.buf, desc = "LSP: [G]oto [D]eclaration" })
          vim.keymap.set("n", "gT", require("telescope.builtin").lsp_type_definitions,
            { buffer = event.buf, desc = "LSP: [T]ype Definition" })
          vim.keymap.set("n", "gs", require("telescope.builtin").lsp_document_symbols,
            { buffer = event.buf, desc = "LSP: Document [S]ymbol" })
          vim.keymap.set("n", "gw", require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { buffer = event.buf, desc = "LSP: [W]orkspace Symbol" })

          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "[G]oto [D]efinition" })
          -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "[G]oto [R]eferences" })
          -- vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0, desc = "[G]oto [I]mplementation" })
          -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "[G]oto [D]eclaration" })
          -- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "[T]ype Definition" })
          -- vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, { buffer = 0, desc = "Document [S]ymbol" })
          -- vim.keymap.set("n", "gw", vim.lsp.buf.workspace_symbol, { buffer = 0, desc = "[W]orkspace Symbol" })
          vim.keymap.set({ "n", "x" }, "<space>r", vim.lsp.buf.rename, { buffer = 0, desc = "LSP: [R]ename" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "LSP: Hover Documentation" })
          vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP: Code [A]ction" })

          local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")

          -- Disable semantic tokens for certain filetypes
          local filetype = vim.bo[event.buf].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Create a keymap to toggle inlay hints if the language server supports them
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end,
              { buffer = event.buf, desc = "LSP: [T]oggle Inlay [H]ints" }
            )
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end,
  },
}
