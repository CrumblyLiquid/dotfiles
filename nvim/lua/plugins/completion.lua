return {
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = (function()
          -- Not supported on Windows and requires the `make` binary
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- Contains a variety of premade snippets.
          -- https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
        opts = {},
      },
      "folke/lazydev.nvim",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",

        -- Accept the current item
        ["<C-space>"] = { "select_and_accept", "fallback" },

        -- Show documentation
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          -- Can show documentation after delay
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = {
          lsp = {
            module = "blink.cmp.sources.lsp",
            -- Exclude keywords/constants from autocomplete
            -- https://cmp.saghen.dev/recipes.html#exclude-keywords-constants-from-autocomplete
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
              end, items)
            end,
          },
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      -- Use LuaSnip for snippets
      -- (also loads any snippets found at `snippets/`)
      snippets = { preset = "luasnip" },

      -- Use the better rust fuzzy search
      fuzzy = { implementation = "rust" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
