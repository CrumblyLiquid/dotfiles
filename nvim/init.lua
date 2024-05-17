-- Heavily based on https://github.com/tjdevries/config.nvim
-- and https://github.com/nvim-lua/kickstart.nvim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

-- Add lazy to the `runtimepath`, this allows us to `require` it
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy
require("lazy").setup({ import = "custom/plugins" }, {
  change_detection = {
    notify = false,
  },
})
