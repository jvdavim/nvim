local spec = { "folke/snacks.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("snacks").setup({
        input = {},
        picker = {},
    })
end)
