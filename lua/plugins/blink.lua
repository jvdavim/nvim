return {
    "saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets' },
    build = 'cargo +nightly build --release',
    opts = {
        sources = {
            -- add lazydev to your completion providers
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },
}
