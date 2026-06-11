return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {},
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
        "typst",
        "rust",
        "python",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
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
        -- Notify the user that there's not Tree-sitter parser available
        -- and return early
        if not vim.treesitter.language.add(language) then
          -- Languages that should be skipped
          local skip_lang = {
            oil = true,
            fidget = true,
            ["blink-cmp-menu"] = true,
            cmd = true,
            msg = true,
            pager = true,
            dialog = true,
          }

          -- https://neovim.io/doc/user/options/#'buftype'
          local buffer_type = vim.bo[buf].buftype

          -- Notify only on file-backed buffers
          if buffer_type == "" and not skip_lang[language] then
            -- https://neovim.io/doc/user/lua/#vim.notify()
            vim.notify(("No Tree-sitter parser for %q"):format(language), vim.log.levels.WARN, { title = "Treesitter" })
          end

          return
        end

        -- Enable syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- Enable Tree-sitter based folds
        -- (for more info see `:help folds`)
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- Enable Tree-sitter based indentation
        -- if it's available for this language
        local has_indent_query = vim.treesitter.query.get(language, "indent") ~= nil
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            vim.notify(
              ("No Tree-sitter support for %q"):format(language),
              vim.log.levels.WARN,
              { title = "Treesitter" }
            )

            return
          end

          treesitter_try_attach(buf, language)
        end,
      })
    end,
  },
}
