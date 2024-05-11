return {
    "ThePrimeagen/harpoon",
    config = function()
        require("harpoon").setup({
            menu = {
                width = vim.api.nvim_win_get_width(0) - 100,
            }
        })
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    end,
}
