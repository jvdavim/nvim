return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        opt = {}
    },

    {
        "artemave/workspace-diagnostics.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "folke/trouble.nvim",
        },
        keys = {
            {
                "<leader>pw",
                function()
                    for _, client in ipairs(vim.lsp.get_clients()) do
                        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
                    end
                end,
                desc = "Populate workspace diagnostics",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "mason-org/mason-lspconfig.nvim",
            "artemave/workspace-diagnostics.nvim",
        },
        opts = {
            servers = {
                tsserver = {
                    init_options = {
                        preferences = {
                            includeCompletionsForModuleExports = true,
                            includeCompletionsForImportStatements = true,
                            importModuleSpecifierPreference = "relative",
                        },
                    },
                },
            },
        },
        config = function()
            -- Configure LSP settings
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "ruff",
                    "omnisharp",
                },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        local capabilities = require("blink.cmp").get_lsp_capabilities()
                        require("lspconfig")[server_name].setup({
                            on_attach = function(client, bufnr)
                                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
                            end,
                            capabilities = capabilities,
                        })
                    end,
                    ["lua_ls"] = function()
                        local capabilities = require("blink.cmp").get_lsp_capabilities()
                        require("lspconfig").lua_ls.setup({
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                            capabilities = capabilities,
                        })
                    end,
                },
            })

            -- Global mappings
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("K", vim.lsp.buf.hover, "Hover")
                    map("<C-i>", vim.lsp.buf.signature_help, "Signature help")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols"
                    )
                    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orksapce [A]dd folder")
                    map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
                    map("<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "[W]orkspace [L]ist folders")
                    map("<leader>D", require("telescope.builtin").lsp_references, "Type [D]efinitions")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                end,
            })
        end,
    },
}
