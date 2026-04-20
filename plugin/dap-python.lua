local spec = { "mfussenegger/nvim-dap-python" }
vim.pack.add({ spec[1] })
vim.pack.add({ "mfussenegger/nvim-dap" })
vim.pack.add({ "rcarriga/nvim-dap-ui" })

pcall(function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
    table.insert(require("dap").configurations.python, { name = "pytest", type = "python", request = "launch", module = "pytest" })
end)
