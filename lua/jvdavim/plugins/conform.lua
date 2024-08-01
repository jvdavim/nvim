return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fw",
            function()
                require("conform").format({ lsp_fallback = true, async = true })
            end,
            mode = "",
            desc = "Format file or range (in visual mode)",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { { "eslint_d", "prettierd", "prettier" } },
            typescript = { { "eslint_d", "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            svelte = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            scss = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            json = { { "jq", "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            graphql = { { "prettierd", "prettier" } },
            csharp = { "dotnet-csharpier" },
            lua = { "stylua" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "isort", "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
            go = { { "gofmt", "gofumpt" } },
            bash = { "shfmt" },
            sh = { "shfmt" },
        },
        format_on_save = false,
    },
    config = function()
        require("conform").setup()
        require("conform.formatters.eslint_d").cwd = require("conform.util").root_file({
            ".eslint.js",
            ".eslint.cjs",
            ".eslint.yaml",
            ".eslint.yml",
            ".eslint.json",
        })
        require("conform.formatters.eslint_d").require_cwd = true
    end,
}
