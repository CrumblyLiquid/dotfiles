return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    -- Load nvim-treesitter only when opening a buffer
    -- for an already existing file or for a new one
    event = { "BufReadPre", "BufNewFile" },
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
        "nix",
        "rust",
        "python",
        "markdown",
        "markdown_inline",
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
