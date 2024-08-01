return {
    'VidocqH/lsp-lens.nvim',
    config = function()
        require 'lsp-lens'.setup({
            enable = true,
            include_declaration = false, -- Reference include declaration
            sections = {                 -- Enable / Disable specific request, formatter example looks 'Format Requests'
                definition = false,
                references = true,
                implements = true,
                git_authors = true,
            },
        })
        local lens = require("lsp-lens.lens-util")
        vim.keymap.set("n", "<leader>l", lens.lsp_lens_toggle)
    end
}
