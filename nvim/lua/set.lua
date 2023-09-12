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

-- Tabbing
o.expandtab = true
local tabsize = 4
o.tabstop = tabsize
o.shiftwidth = tabsize

-- Highlighting --
-- Highlight all matching strings
-- remove higlights with :nohlsearch
o.hlsearch = false
o.incsearch = true
