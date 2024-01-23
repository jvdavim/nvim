local builtin = require("telescope.builtin")

-- Open FuzzyFinder
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]uzzy [F]ind Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]uzzy [G]rep files" })
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Fuzzy Find Files (alt)" })

-- Searches on files tracked by git
-- avoid searching huge node_modules files that should be .gitignored
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find on git opened files" })

vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "[F]uzzy Find current [B]uffer" })
