local spec = { "lukas-reineke/indent-blankline.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("ibl").setup()
end)
