local spec = { "iamcco/markdown-preview.nvim" }
vim.pack.add({ spec[1] })

if vim.fn.executable("npx") then
    -- Attempt to run plugin build steps using its directory if available
    local plugin_dir = vim.fn.stdpath("data") .. "/site/pack/*/opt/markdown-preview.nvim"
    -- best-effort only; fall back to internal installer
    pcall(function()
        vim.fn["mkdp#util#install"]()
    end)
end

if vim.fn.executable("npx") then
    vim.g.mkdp_filetypes = { "markdown" }
end

vim.keymap.set("n", "<leader>s", "<cmd> MarkdownPreview <CR>")
