return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Not supported on Windows and requires the `make` binary
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- Contains a variety of premade snippets.
          -- https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        }
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-buffer",

      "onsails/lspkind.nvim",
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
      vim.opt.shortmess:append("c")

      local lspkind = require("lspkind")

      -- Luasnip config below
      local luasnip = require("luasnip")

      luasnip.config.set_config({
        history = false,
        updateevents = "TextChanged,TextChangedI",
      })

      -- Load snippets
      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
        loadfile(ft_path)()
      end

      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          -- It's more annyoying than helpful
          -- { name = "buffer" },
          { name = "path" },
          -- Skip loading LauLS (layzdev recommends this)
          { name = "lazydev", group_index = 0 },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- ["<C-n>"] = cmp.mapping.select_next_item(),
          -- ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- https://www.reddit.com/r/neovim/comments/u7nsje/nvimcmp_completion_issue_cn_gives_basic_completion/
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),

          ["<C-Space>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp
          ["<C-y>"] = cmp.mapping.complete({}),

          -- Moving through the snippet expansion
          ["<Tab>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        -- https://github.com/onsails/lspkind.nvim
        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            -- show only symbol annotations
            mode = 'symbol',
            -- prevent the popup from showing more than provided characters
            maxwidth = function() return math.floor(0.35 * vim.o.columns) end,
            -- when popup menu exceed maxwidth, truncate with ellispis_char
            ellipsis_char = '...',
            show_labelDetails = true,
          })
        }
      })
    end,
  },
}
