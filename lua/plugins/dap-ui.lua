return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dapui = require("dapui")
        dapui.setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.25,
                        },
                        {
                            id = "breakpoints",
                            size = 0.2,
                        },
                        {
                            id = "stacks",
                            size = 0.2,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        },
                        {
                            id = "console",
                            size = 0.1,
                        },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 1,
                        },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
        })
        vim.keymap.set("n", "<leader>b", "<cmd> DapToggleBreakpoint <CR>")
        vim.keymap.set("n", "<leader>db", "<cmd> DapContinue <CR>")
        vim.keymap.set("n", "<leader>dt", function()
            require("dapui").toggle()
        end, { silent = true })
        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })
    end,
}
