-- Make line numbers default
vim.o.number = true
-- Make line numbers relative
vim.o.relativenumber = true

-- Tabbing
local tabsize = 4
vim.o.expandtab = true
vim.o.tabstop = tabsize
vim.o.shiftwidth = tabsize

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 150

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Disable line wrapping
vim.o.wrap = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "popup" }
vim.opt.shortmess:append("c")
