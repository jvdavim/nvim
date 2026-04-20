local spec = { "VidocqH/lsp-lens.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("lsp-lens").setup({ enable = false, include_declaration = false, sections = { definition = false, references = true, implements = true, git_authors = true } })
    local lens = require("lsp-lens.lens-util")
    vim.keymap.set("n", "<leader>l", lens.lsp_lens_toggle)
end)
