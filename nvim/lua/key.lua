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
        d = {
            name = "Debug",
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

-- Debugging
vim.keymap.set("n", "<leader>do", require("dapui").toggle, { desc = "Toggle debug UI" })
vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Start debugging" })
vim.keymap.set("n", "<F2>", require("dap").step_over, { desc = "Step over" })
vim.keymap.set("n", "<F1>", require("dap").step_into, { desc = "Step into" })
vim.keymap.set("n", "<F3>", require("dap").step_out, { desc = "Step out" })

vim.keymap.set("n", "<leader>dr", require("dap").repl.toggle, { desc = "Toggle repl" })
vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", (function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end),
    { desc = "Set breakpoint condition" })
vim.keymap.set("n", "<leader>dl",
    (function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end),
    { desc = "Set log point" })

-- Trouble
vim.keymap.set("n", "<leader>dd", vim.cmd.TroubleToggle, { desc = "Toggle diagnostics" })

-- Search terms stay in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Half page jumping but keep the cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste without loosing the content of the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy to clipboard" })

-- Source the current buffer
-- vim.keymap.set("n", "<leader><leader>", "<cmd>so<cr>", { desc = "Source current buffer", })

-- Format the whole file
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
