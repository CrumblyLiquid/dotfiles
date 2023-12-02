local o = vim.opt

-- Mouse stuff --
-- Mouse support in all modes
o.mouse = 'a'

-- Line stuff --
o.number = true
o.relativenumber = true
o.numberwidth = 4
o.cursorline = true
o.cursorlineopt = 'number'
o.wrap = false

-- Folding --
-- https://github.com/kevinhwang91/nvim-ufo
o.foldcolumn = '1'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Tabbing --
o.expandtab = true
local tabsize = 4
o.tabstop = tabsize
o.shiftwidth = tabsize

-- Highlighting --
-- Highlight all matching strings
-- remove higlights with :nohlsearch
o.hlsearch = false
o.incsearch = true

-- Case-insensitive searching UNLESS \C or capital in search
o.ignorecase = true
o.smartcase = true

-- Save undo history
o.undofile = true
