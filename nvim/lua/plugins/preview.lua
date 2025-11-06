return {
  {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
      -- Typst
      {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        -- lazy = true,
        opts = {
          dependencies_bin = {
            ['tinymist'] = 'tinymist',
            ['websocat'] = 'websocat',
          },
        }
      },
      -- CSV
      { 'hat0uma/csvview.nvim', lazy = true },
      -- Markdown
      {
        "toppair/peek.nvim",
        lazy = true,
        build = "deno task --quiet build:fast",
        opts = {
          app = "browser",
        }
      }
    },
    opts = {},
    keys = {
      { "<leader>po", function() require('omni-preview').command({ args = "start" }) end, desc = "Start preview" },
      { "<leader>pc", function() require('omni-preview').command({ args = "stop" }) end,  desc = "Stop preview" },
    }
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons'
    }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }
}
