vim.g.mapleader = " "

-- move lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })

-- Append line below to curr line
vim.keymap.set("n", "J", "mzJ`z", { desc = "append line below to current line" })

-- clipboard stuff
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[y]ank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[y]ank to system clipboard" })

vim.keymap.set("n", "Q", "<nop>", { desc = "noop" })

--
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit, { desc = "[v]ertical [s]plit" })

vim.keymap.set(
    "n",
    "<leader>e",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    { noremap = true, silent = true }
)

--
vim.keymap.set("n", "<leader>rl", vim.cmd.LspRestart, { desc = "[r]estart [l]sp server" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP')
