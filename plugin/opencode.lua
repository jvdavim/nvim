local spec = { "nickjvandyke/opencode.nvim" }
vim.pack.add({ spec[1] })

pcall(function()
    local opencode_cmd = "opencode --port"
    ---@type table
    local snacks_terminal_opts = {
        win = {
            position = "right",
            enter = false,
            on_win = function(win)
                require("opencode.terminal").setup(win.win)
            end,
        },
    }

    ---@type table
    vim.g.opencode_opts = {
        server = {
            start = function()
                require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
            end,
            stop = function()
                require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
            end,
            toggle = function()
                require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
            end,
        },
    }

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ")
    end, { desc = "[o]pencode [a]sk" })

    vim.keymap.set({ "n", "x" }, "<leader>os", function()
        require("opencode").select()
    end, { desc = "[o]pencode [s]elect" })

    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
    end, { desc = "[o]pencode [t]oggle" })

    vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "move left split" })
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "move right split" })

    require("lualine").setup({
        sections = {
            lualine_z = {
                {
                    require("opencode").statusline,
                },
            },
        },
    })
end)
