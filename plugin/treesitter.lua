local spec = { "nvim-treesitter/nvim-treesitter" }
vim.pack.add({ spec[1] })

pcall(function()
    local ts = require("nvim-treesitter")
    local languages = {
        "c",
        "c_sharp",
        "kotlin",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "java",
        "gitcommit",
    }

    ts.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

    if vim.fn.executable("tree-sitter") == 1 then
        ts.install(languages)
    end

    if #vim.api.nvim_get_runtime_file("parser/python.so", true) == 0 then
        local fallback = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
        if vim.uv.fs_stat(fallback .. "/parser/python.so") then
            vim.opt.runtimepath:append(fallback)
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
            pcall(vim.treesitter.start, args.buf)
        end,
    })
end)
