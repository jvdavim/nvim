local spec = { "nvim-telescope/telescope.nvim" }
vim.pack.add({ spec[1] })
vim.pack.add({ "nvim-lua/plenary.nvim" })

pcall(function()
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    telescope.setup({ pickers = { find_files = { hidden = true, no_ignore = true, find_command = { "rg", "--files", "--hidden", "--glob=!**/{.git,.venv,node_modules}/*" } } } })

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]uzzy [F]ind Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]uzzy [G]rep files" })
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Fuzzy Find Files (alt)" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find on git opened files" })
    vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "[F]uzzy Find current [B]uffer" })
end)
