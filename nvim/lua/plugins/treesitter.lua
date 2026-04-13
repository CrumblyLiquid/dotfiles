return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local parsers = {
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
        "lambdalus",
      }
      require("nvim-treesitter").install(parsers)

      vim.filetype.add({
        extension = {
          lambdalus = "lambdalus",
        },
      })
      vim.treesitter.language.register("lambdalus", "lambdalus")

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").lambdalus = {
            install_info = {
              url = "https://github.com/CrumblyLiquid/tree-sitter-lambdalus",
              revision = "HEAD",
              -- optional entries:
              -- queries = "queries/neovim", -- also install queries from given directory
            },
          }
        end,
      })

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based folds
        -- for more info on folds see `:help folds`
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, "indent") ~= nil

        -- enables treesitter based indentation
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          treesitter_try_attach(buf, language)
        end,
      })
    end,
  },
}
