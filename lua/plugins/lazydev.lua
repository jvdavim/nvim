local spec = { "folke/lazydev.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    -- try to configure if module present
    local ok, mod = pcall(require, "lazydev")
    if ok and type(mod.setup) == "function" then
        mod.setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end
end)
