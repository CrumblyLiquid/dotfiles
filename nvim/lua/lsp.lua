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
  -- "hls",
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
  "prolog_ls", -- requires https://github.com/jamesnvc/lsp_server
  -- Python
  "ruff",
  "sqruff",
  -- Hyprland
  -- "hyprls",
  -- R
  "air",
  -- PHP
  "phpactor",
  "phan",

  -- Writing
  -- "ltex_plus",
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config(
  ---@type vim.diagnostic.Opts
  {
    severity_sort = true,
    ---@type vim.diagnostic.Opts.Float
    float = { border = "rounded", source = "if_many" },
    ---@type vim.diagnostic.Opts.Signs
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
    } or {},
    ---@type vim.diagnostic.Opts.Underline
    underline = { severity = vim.diagnostic.severity.ERROR },
    ---@type vim.diagnostic.Opts.VirtualText
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
  }
)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    vim.keymap.set(
      "n",
      "gd",
      require("telescope.builtin").lsp_definitions,
      { buffer = event.buf, desc = "LSP: [G]oto [D]efinition" }
    )
    vim.keymap.set(
      "n",
      "gr",
      require("telescope.builtin").lsp_references,
      { buffer = event.buf, desc = "LSP: [G]oto [R]eferences" }
    )
    vim.keymap.set(
      "n",
      "gI",
      require("telescope.builtin").lsp_implementations,
      { buffer = event.buf, desc = "LSP: [G]oto [I]mplementation" }
    )
    -- vim.keymap.set("n", "gD", require("telescope.builtin").lsp_declarations,
    --   { buffer = event.buf, desc = "LSP: [G]oto [D]eclaration" })
    vim.keymap.set(
      "n",
      "gT",
      require("telescope.builtin").lsp_type_definitions,
      { buffer = event.buf, desc = "LSP: [T]ype Definition" }
    )
    vim.keymap.set(
      "n",
      "gs",
      require("telescope.builtin").lsp_document_symbols,
      { buffer = event.buf, desc = "LSP: Document [S]ymbol" }
    )
    vim.keymap.set(
      "n",
      "gw",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      { buffer = event.buf, desc = "LSP: [W]orkspace Symbol" }
    )

    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "[G]oto [D]efinition" })
    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "[G]oto [R]eferences" })
    -- vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0, desc = "[G]oto [I]mplementation" })
    -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "[G]oto [D]eclaration" })
    -- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "[T]ype Definition" })
    -- vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, { buffer = 0, desc = "Document [S]ymbol" })
    -- vim.keymap.set("n", "gw", vim.lsp.buf.workspace_symbol, { buffer = 0, desc = "[W]orkspace Symbol" })
    vim.keymap.set({ "n", "x" }, "<space>r", vim.lsp.buf.rename, { buffer = 0, desc = "LSP: [R]ename" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "LSP: Hover Documentation" })
    vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP: Code [A]ction" })

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "Must have valid client")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- Create a keymap to toggle inlay hints if the language server supports them
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { buffer = event.buf, desc = "LSP: [T]oggle Inlay [H]ints" })
    end
  end,
})
