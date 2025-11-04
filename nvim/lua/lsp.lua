-- https://www.youtube.com/watch?v=IZnhl121yo0

-- Enable LSP servers
-- (configured in `lua/plugins/` or `lsp/`)
vim.lsp.enable({
  -- Lua
  "lua_ls",
  -- Rust
  "rust_analyzer",
  -- C/C++
  "clangd",
  -- Bash
  "bashls",
  -- Nix
  "nil_ls",
  -- Haskell
  "hls",
  -- Typst
  "tinymist",
  -- HTML/CSS/JavaScript
  "emmet_language_server",
  "prettierd",
  -- TODO: Capabilities
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
  "cssls",
  "css_variables",
  -- Json
  "jsonls",
  -- Yaml
  "yamlls",
  -- Prolog
  -- "prolog_ls", -- requires https://github.com/jamesnvc/lsp_server
  -- Python
  "ruff",
  "sqruff",
  -- Hyprland
  -- "hyprls",
  -- R
  "air",

  -- Writing
  "ltex_plus",
})

-- Settings here:
-- https://ltex-plus.github.io/ltex-plus/settings.html
vim.lsp.config("ltex_plus", {
  settings = {
    ltex = {
      checkFrequency = "save",
      -- language = "en-GB",
    },
  },
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    -- TODO: Why?
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
