return {
    "VidocqH/lsp-lens.nvim",
    config = function()
        require("lsp-lens").setup({
            enable = false,
            include_declaration = false,
            sections = {
                definition = false,
                references = true,
                implements = true,
                git_authors = true,
            },
        })
        local lens = require("lsp-lens.lens-util")
        vim.keymap.set("n", "<leader>l", lens.lsp_lens_toggle)
    end,
}
