require("jvdavim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "folke/tokyonight.nvim" },
    { "folke/trouble.nvim",   dependencies = { "nvim-tree/nvim-web-devicons", opts = {} } },
    { "folke/neodev.nvim" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    { "lewis6991/gitsigns.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "mhartington/formatter.nvim" },
    { "mrjones2014/smart-splits.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        ensure_installed = {
            "bash",
            "python",
            "rust",
            "javascript",
            "lua",
            "luadoc",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
            "json",
            "markdown",
            "markdown_inline",
            "regex",
            "toml",
            "jsonc",
            "jsdoc",
            "html",
            "diff",
            "go",
            "c",
            "java",
            "ocaml",
            "php",
            "sql",
            "xml",
            "c_sharp",
            "css",
            "csv",
            "cuda",
            "dockerfile",
            "gitcommit",
            "gitignore",
            "gitattributes",
        },
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "VonHeikemen/lsp-zero.nvim",        branch = "v2.x" },
})
