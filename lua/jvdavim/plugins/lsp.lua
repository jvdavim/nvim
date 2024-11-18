return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["C-<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },

    -- Auto populate workspace diagnostics
    {
        "artemave/workspace-diagnostics.nvim",
        event        = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "folke/trouble.nvim",
        },
        keys         = {
            {
                "<leader>pw",
                function()
                    for _, client in ipairs(vim.lsp.get_clients()) do
                        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
                    end
                end,
                desc = "Populate workspace diagnostics"
            }
        },
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "artemave/workspace-diagnostics.nvim" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
                if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
                    local semantic = client.config.capabilities.textDocument.semanticTokens
                    client.server_capabilities.semanticTokensProvider = {
                        full = true,
                        legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
                        range = true,
                    }
                end
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "gopls",
                    "omnisharp",
                    "ts_ls",
                    "eslint",
                    "angularls",
                    "html",
                    "tailwindcss",
                    "dockerls",
                    "rust_analyzer",
                },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            on_attach = function(client, bufnr)
                                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
                            end
                        })
                    end,

                    -- this is the "custom handler" for `lua_ls`
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<C-i>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                end,
            })
        end,
    },
}
