return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "horizon",
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 2,
                        fmt = function(path)
                            return table.concat(
                                { vim.fs.dirname(path), vim.fs.basename(path) },
                                package.config:sub(1, 1)
                            )
                        end,
                    },
                },
            },
        })
    end,
}
