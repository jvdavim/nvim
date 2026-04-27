local spec = { "saghen/blink.cmp" }
vim.pack.add({ spec[1] })
vim.pack.add({ "rafamadriz/friendly-snippets" })

pcall(function()
    local ok, blink = pcall(require, "blink.cmp")
    if ok and type(blink.setup) == "function" then
        blink.setup({
            -- Prefer prebuilt binaries v1.* instead of building locally
            fuzzy = {
                prebuilt_binaries = { force_version = "1.*" },
                -- If prebuilt download fails, use the Lua fallback quietly
                implementation = "lua",
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        })
    end
end)
