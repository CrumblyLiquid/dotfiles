vim.g.mapleader = " "

-- Which-Key
-- Press <leader> to show the help menu
-- Press ` or " to show local or global marks in your buffer
-- Press " in normal mode to show registers
local wk = require("which-key")
wk.register(
    {
        f = {
            name = "File",
        },
        l = {
            name = "LSP",
        },
        ["<leader>"] = "which_key_ignore",
    },
    {
        prefix = "<leader>",
        mode = "n",
    }
)
-- <LEADER>

-- Write and quit
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit" })

-- Open and close the Netrw file explorer
vim.keymap.set("n", "<leader>fe", vim.cmd.Explore, { desc = "Open explorer" })
vim.keymap.set("n", "<leader>fc", vim.cmd.Rexplore, { desc = "Close explorer" })

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Grep files" })

-- Make file in the current buffer executable
vim.keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Search buffers
vim.keymap.set("n", "<leader>b", telescope.buffers, { desc = "Buffers" })

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- Search terms stay in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Source the current buffer
vim.keymap.set("n", "<leader><leader>", "<cmd>so<cr>", { desc = "Source current buffer", })

-- Format the whole file
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
