return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    -- Load nvim-treesitter only when opening a buffer
    -- for an already existing file or for a new one
    event = { "BufReadPre", "BufNewFile" },
    -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    build = function()
      -- :TSUpdate won't work on first install
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    main = "nvim-treesitter.configs",
    -- https://www.lazyvim.org/plugins/treesitter
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "html",
        "css",
        "json",
        "javascript",
        "comment",
        "lua",
        "luadoc",
        "nix",
        "rust",
        "python",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      },
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
