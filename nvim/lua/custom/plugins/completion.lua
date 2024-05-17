return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      vim.opt.shortmes:append("c")

      local lspkind = require("lspkind")
      lspkind.init({})

      -- Luasnip config below
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = cmp.mapping.preset.insert({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },

          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

          ["<C-Space>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { "i", "c" }
          ),

          -- Manually trigger a completion from nvim-cmp
          ["<C-y>"] = cmp.mapping.complete({}),

          -- Moving through the snippet expansion
          ["<C-N>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),

          ["<C-P>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
      })

      luasnip.config.set_config({
        history = false,
        updateevents = "TextChanged,TextChangedI",
      })

      -- Load snippets
      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
        loadfile(ft_path)()
      end
    end,
  },
}
