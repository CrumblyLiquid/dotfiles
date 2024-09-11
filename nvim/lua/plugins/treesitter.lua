return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Fix treesitter madness
    -- (https://www.reddit.com/r/neovim/comments/110x08m/treesitter_keeps_recompiling_parsers/)
    version = nil,
    lazy = false,
    build = function()
      -- :TSUpdate won't work on first install
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
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
        "vim",
        "vimdoc",
        "nix",
        "rust",
        "python",
        "markdown",
        "markdown_inline",
        "query",
        "diff",
        "vim",
        "vimdoc"
      },
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
}
