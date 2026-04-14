local spec = { "folke/snacks.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    require("snacks").setup({
        input = {},
        terminal = {},
        picker = {
            actions = {
                opencode_send = function(...)
                    return require("opencode").snacks_picker_send(...)
                end,
            },
            win = {
                input = {
                    keys = {
                        ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                    },
                },
            },
        },
    })
end)
