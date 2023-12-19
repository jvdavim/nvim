local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[a]dd file to harpoon list" })
vim.keymap.set("n", "<M-m>", ui.toggle_quick_menu, { desc = "open harpoon [m]enu" })

vim.keymap.set("n", "<M-Esc>", ui.nav_next, { desc = "next harpoon item" })
