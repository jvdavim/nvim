local repo = "williamboman/mason.nvim"
vim.pack.add({ repo })
vim.pack.add({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
vim.pack.add({ "williamboman/mason-lspconfig.nvim" })

pcall(function()
    -- Make sure mason's bin path is available to subprocesses
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if vim.env.PATH and vim.env.PATH:find(mason_bin, 1, true) == nil then
        vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
    end

    local ok, mason = pcall(require, "mason")
    if ok and type(mason.setup) == "function" then
        mason.setup({ PATH = "append" })
    end

    local ok2, mti = pcall(require, "mason-tool-installer")
    if ok2 and type(mti.setup) == "function" then
        mti.setup({
            ensure_installed = {
                "angular-language-server",
                "csharp-language-server",
                "csharpier",
                "debugpy",
                "delve",
                "dockerfile-language-server",
                "eslint-lsp",
                "eslint_d",
                "gopls",
                "html-lsp",
                "jdtls",
                "jq",
                "lua-language-server",
                "prettierd",
                "pyright",
                "ruff",
                "ruff-lsp",
                "rust-analyzer",
                "shfmt",
                "sonarlint-language-server",
                "stylua",
                "tailwindcss-language-server",
                "ty",
                "typescript-language-server",
            },
            auto_update = false,
            run_on_start = true,
            start_delay = 3000,
        })
    end

    -- Ensure mason-lspconfig is present and setup to bridge mason and lspconfig
    local ok3, mls = pcall(require, "mason-lspconfig")
    if ok3 and type(mls.setup) == "function" then
        mls.setup()
    end
end)
