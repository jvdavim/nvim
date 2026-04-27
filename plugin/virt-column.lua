local spec = { "lukas-reineke/virt-column.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    local ok, mod = pcall(require, "virt-column")
    if ok and type(mod.setup) == "function" then
        mod.setup({ char = { "┆" }, virtcolumn = "80, 120, 140", highlight = { "NonText", "WarningMsg", "ErrorMsg" } })
    end
end)
