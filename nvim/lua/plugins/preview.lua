return {
  {
    "sylvanfranklin/omni-preview.nvim",
    dependencies = {
      -- Typst
      { 'chomosuke/typst-preview.nvim', lazy = true },
      -- CSV
      { 'hat0uma/csvview.nvim',         lazy = true },
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
}
