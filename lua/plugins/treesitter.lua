local spec = { "nvim-treesitter/nvim-treesitter" }
vim.pack.add({ spec[1] })

pcall(function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "python",
            "java",
            "gitcommit",
        },
        sync_install = false,
        auto_install = false,
        ignore_install = { "javascript" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
    })
    require("nvim-treesitter.install").prefer_git = true
end)
