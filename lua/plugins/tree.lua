return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- use all default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- remove defaults
            vim.keymap.del("n", "<C-e>", { buffer = bufnr })
            vim.keymap.del("n", "f", { buffer = bufnr })

            -- custom mappings
            vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
            vim.keymap.set("n", "<leader>x", "<cmd> NvimTreeToggle <CR>")
        end
        require("nvim-tree").setup({
            on_attach = my_on_attach,
            git = {
                ignore = false,
            },
            filters = { custom = { "^.git$" } },
        })
    end,
}
