return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-tree").setup({
            filters = { custom = { "^.git$" } },
            vim.keymap.set("n", "<leader>x", "<cmd> NvimTreeToggle <CR>"),
        })
    end,
}
