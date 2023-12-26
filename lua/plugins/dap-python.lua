return {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, _)
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap.ext.vscode").load_launchjs()
        require("dap-python").setup(path)
    end,
}
