# NeoVim

Vi improved improved.

This configuration is partly based on the great
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
If you're not sure where to start then use `kickstart.nvim` and
use this config as an inspiration for additional plugins or
features.

Most of the configuration is not documented as I'm not
really sure what some parts really do.

## Configuration

The main configuration entry point is `init.lua`
but there are a some paths that are
loaded in specific situations.

- `init.lua` - main entry point
- `ftplugins/filetype.lua` - loaded based on the buffer's filetype
- `snippets/*` - snippets loaded by `blink.cmp`

_I'll complete this section once I finish my Neovim config rewrite._

## Plugins

- [`ThePrimeagen/harpoon`]()
- [`nvim-telescope/telescope.nvim`]()
- [`neovim/nvim-lspconfig`]()
- [`mason-org/mason.nvim`]()
- [`saghen/blink.cmp`]()
- [`L3MON4D3/LuaSnip`]()
- [`catppuccin/nvim`]()
- [`numToStr/Comment.nvim`]()
- [`folke/todo-comments.nvim`]()
- [`stevearc/oil.nvim`]()
- [`kevinhwang91/nvim-ufo`]()
- [`stevearc/conform.nvim`]()
- [`lukas-reineke/indent-blankline.nvim`]()
- [`echasnovski/mini.nvim`]()
- [`sylvanfranklin/omni-preview.nvim`]()
- [`kylechui/nvim-surround`]()
- More... (TODO)

## Todo

Misc:

- Rewrite lsp, completion and formatting configuration
    - `lsp.lua`
    - `completaion.lua`
    - `treesitter.lua`
    - `debugging.lua`

- Better treesitter config
    - https://www.josean.com/posts/nvim-treesitter-and-textobjects

- Add propper snippets configuration and custom snippets

Plugins:

- [arrow.nvim](https://github.com/otavioschwanck/arrow.nvim) - better harpoon.nvim

