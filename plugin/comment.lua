vim.pack.add({ "numToStr/Comment.nvim" })

pcall(function()
    require("Comment").setup({
        pre_hook = function()
            return vim.bo.commentstring
        end,
    })
end)
