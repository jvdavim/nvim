local spec = { "nvim-tree/nvim-tree.lua" }
vim.pack.add({ spec[1] })
vim.pack.add({ "nvim-tree/nvim-web-devicons" })

pcall(function()
    local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del("n", "<C-e>", { buffer = bufnr })
        vim.keymap.del("n", "f", { buffer = bufnr })
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "<leader>x", "<cmd> NvimTreeToggle <CR>")
    end

    require("nvim-tree").setup({ on_attach = my_on_attach, git = { ignore = false }, filters = { custom = { "^.git$" } } })
end)
