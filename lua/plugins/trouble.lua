local spec = { "folke/trouble.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    local ok, trouble = pcall(require, "trouble")
    if ok and type(trouble.setup) == "function" then
        trouble.setup({})
    end
end)

-- keymaps (best-effort)
pcall(function()
    vim.keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>")
    vim.keymap.set("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
    vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>")
    vim.keymap.set("n", "gR", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
    vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<cr>")
    vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>")
end)
