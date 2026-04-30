-- dependencies used by pymple
vim.pack.add({ "nvim-lua/plenary.nvim" })
vim.pack.add({ "MunifTanjim/nui.nvim" })
-- optional niceties
vim.pack.add({ "stevearc/dressing.nvim" })
vim.pack.add({ "nvim-tree/nvim-web-devicons" })

local spec = { "alexpasmantier/pymple.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    -- Defer setup until after startup so other plugin modules (like
    -- nvim-tree) have a chance to initialize and pymple can hook into them.
    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
            local ok, pymple = pcall(require, "pymple")
            if not ok or type(pymple.setup) ~= "function" then
                return
            end

            pcall(function()
                pymple.setup({})
            end)
        end,
    })
end)

-- Diagnostic helper: allow manually triggering update_imports for testing.
pcall(function()
    vim.keymap.set("n", "<leader>pup", function()
        local source = vim.fn.input("Source path: ")
        if source == nil or source == "" then
            print("Source required")
            return
        end
        local destination = vim.fn.input("Destination path: ")
        if destination == nil or destination == "" then
            print("Destination required")
            return
        end
        local ok, api = pcall(require, "pymple")
        if not ok then
            print("pymple not available")
            return
        end
        api.update_imports(source, destination, require("pymple.config").user_config.update_imports)
    end, { desc = "Pymple: manual update imports" })
end)
