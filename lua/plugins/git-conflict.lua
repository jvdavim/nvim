local spec = { "akinsho/git-conflict.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("git-conflict").setup()
end)
