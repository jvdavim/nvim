local repo = "williamboman/mason.nvim"
vim.pack.add({ repo })
vim.pack.add({ "WhoIsSethDaniel/mason-tool-installer.nvim" })

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
                "csharpier",
                "debugpy",
                "html-lsp",
                "jq",
                "kotlin-language-server",
                "ktlint",
                "lua-language-server",
                "netcoredbg",
                "omnisharp",
                "pyright",
                "ruff",
                "shfmt",
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

end)
