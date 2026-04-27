vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local tele = require("telescope.builtin")
        map("gd", tele.lsp_definitions, "[G]oto [D]efinition")
        map("gi", tele.lsp_implementations, "[G]oto [I]mplementations")
        map("gr", tele.lsp_references, "[G]oto [R]eferences")
        map("<leader>ds", tele.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>D", tele.lsp_references, "Type [D]efinitions")

        map("<leader>e", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-i>", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        local wk = require("which-key")
        wk.add({
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
            { "<C-i>", vim.lsp.buf.signature_help, desc = "Display Signature Information" },
            { "<leader>rn", vim.lsp.buf.rename, desc = "Rename all references" },
            { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Workspace Add Folder" },
            { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove Folder" },
            {
                "<leader>wl",
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                desc = "Workspace List Folders",
            },
        })

        local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})
