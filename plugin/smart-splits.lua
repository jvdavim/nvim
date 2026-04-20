local spec = { "mrjones2014/smart-splits.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("smart-splits").setup({
        ignored_filetypes = { "nofile", "quickfix", "prompt" },
        ignored_buftypes = { "NvimTree" },
        default_amount = 5,
        at_edge = "wrap",
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        resize_mode = { quit_key = "<ESC>", resize_keys = { "h", "j", "k", "l" }, silent = false },
        ignored_events = { "BufEnter", "WinEnter" },
        multiplexer_integration = nil,
        disable_multiplexer_nav_when_zoomed = true,
    })

    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "resize left" })
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "resize left" })
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "resize up" })
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "resize right" })
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "move left split" })
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "move down split" })
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "move up split" })
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "move right split" })
    vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
end)
