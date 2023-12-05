-- TODO: Explore these
-- https://learnvimscriptthehardway.stevelosh.com/chapters/42.html
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- https://github.com/tpope/vim-sleuth

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
            -- Adds LSP completion capabilities
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            -- Snippet Engine & its associated nvim-cmp source
            {"L3MON4D3/LuaSnip"},
            {"saadparwaiz1/cmp_luasnip"},
            -- Adds a number of user-friendly snippets
            {"rafamadriz/friendly-snippets"},
        }
    },
    -- Neodev - setup for Neovim configuration
    {
        "folke/neodev.nvim",
    },
    -- Indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" }
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
require("neodev").setup()

-- Setup LSP Zero
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
require("ibl").setup {
    scope = {
        enabled = true,
        show_end = true,
    },
}

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert"
    },
    -- TODO: Move mappings to key.lua
    mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
}

-- nvim-autopairs support for completion
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
