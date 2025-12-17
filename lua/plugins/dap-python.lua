return {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    build = {
        type = "builtin",
        copy_directories = {
            "doc",
        },
    },
    config = function(_, _)
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
        table.insert(require("dap").configurations.python, {
            name = "pytest",
            type = "python",
            request = "launch",
            module = "pytest",
        })
    end,
}
