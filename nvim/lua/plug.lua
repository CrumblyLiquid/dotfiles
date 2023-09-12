local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    -- Keybinding help
    {
        "folke/which-key.nvim",
        name = "which-key",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    -- File search, etc.
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    -- Better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c", "cpp", "make", "rust", "python",
                    "html", "javascript", "css", "scss",
                    "lua", "bash", "yuck", "toml",
                    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                    "latex", "markdown_inline", "vim", "vimdoc", "query"
                },
		-- Install parsers synchronously (only applies to `ensuer_installed`)
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    -- LSP Zero - LSP configuration
    {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
    -- UI for managing LSPs, DAPS, linters and formatters
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    -- Easy LSP configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {"hrsh7th/cmp-nvim-lsp"},
        },
    },
    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {"L3MON4D3/LuaSnip"},
        }
    },
    -- Neodev - setup for Neovim configuration
    -- {
    --     "folke/neodev.nvim",
    -- },
    -- Indent lines
    {
        "lukas-reineke/indent-blankline.nvim"
    },
    -- Undo tree
    {
        "mbbill/undotree"
    },
    -- Autopair brackets, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
        }
    },
    -- Git signs
    {
        "lewis6991/gitsigns.nvim"
    },
    -- Diagnostics
    {
       "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
})

-- Set colorscheme
vim.cmd.colorscheme("catppuccin")

-- Setup neodev (neovim plugin developement)
-- Needs to be before lspconfig
-- require("neodev").setup()

-- Setup LSP Zero
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "clangd",
        "rust_analyzer",
        "pyright",
        "ruff_lsp",
        "emmet_language_server",
        "ltex",
        "lua_ls"
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

-- New line indicator
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- Indent lines config
require("indent_blankline").setup {
    show_current_context = true,
    show_end_of_line = true,
}

-- nvim-autopairs support for completion
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ts_utils = require("nvim-treesitter.ts_utils")

local ts_node_func_parens_disabled = {
    -- ecma
    named_imports = true,
    -- rust
    use_declaration = true,
}

local default_handler = cmp_autopairs.filetypes["*"]["("].handler
cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
    local node_type = ts_utils.get_node_at_cursor():type()
    if ts_node_func_parens_disabled[node_type] then
        if item.data then
            item.data.funcParensDisabled = true
        else
            char = ""
        end
    end
    default_handler(char, item, bufnr, rules, commit_character)
end

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        sh = false,
    })
)

-- Lualine setup
require("lualine").setup()

-- Gitsigns setup
require("gitsigns").setup()

-- Comment.nvim
require("Comment").setup()
