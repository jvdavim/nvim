local spec = {
    "folke/which-key.nvim",
    -- Keep which-key loaded eagerly under lazy.nvim; keep event removed when using builtin.
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {},
}

vim.pack.add({ spec[1] })

if type(spec.init) == "function" then
    pcall(spec.init)
end

if type(spec.opts) == "table" then
    local mod = spec[1]:match("/([^/]+)$"):gsub("%.nvim$", "")
    pcall(function()
        require(mod).setup(spec.opts)
    end)
end
