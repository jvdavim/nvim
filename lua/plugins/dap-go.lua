local spec = { "leoluz/nvim-dap-go" }
vim.pack.add({ spec[1] })
vim.pack.add({ "mfussenegger/nvim-dap" })

pcall(function()
    require("dap-go").setup({ dap_configurations = { { type = "go", name = "Attach remote", mode = "remote", request = "attach" } }, delve = { path = "dlv" } })
end)
