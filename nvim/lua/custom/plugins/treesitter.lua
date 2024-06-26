return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      local M = {}

      M.setup = function()
        local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

        require("nvim-treesitter").setup {
          ensure_installed = {
            "community",
            "bash",
            "c",
            "cpp",
            "html",
            "lua",
            "vim",
            "vimdoc",
            "nix",
            "rust",
            "python",
          },
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        }

        local syntax_on = {
          elixir = true,
          php = true,
        }

        vim.api.nvim_create_autocmd("FileType", {
          group = group,
          callback = function(args)
            local bufnr = args.buf
            local ft = vim.bo[bufnr].filetype
            pcall(vim.treesitter.start)

            if syntax_on[ft] then
              vim.bo[bufnr].syntax = "on"
            end
          end,
        })
      end

      M.setup()

      return M
    end,
  },
}
