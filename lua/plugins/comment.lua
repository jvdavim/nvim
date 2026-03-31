local spec = { "numToStr/Comment.nvim" }
vim.pack.add({ spec[1] })
pcall(function()
    require("Comment").setup()
end)
