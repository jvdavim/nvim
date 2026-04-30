return {
    cmd = { "pyright-langserver", "--stdio" },
    -- Keep pyright available for workspace diagnostics while ty owns the
    -- interactive Telescope-backed navigation for Python buffers.
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    on_attach = function(client)
        for _, capability in ipairs({
            "definitionProvider",
            "implementationProvider",
            "referencesProvider",
            "typeDefinitionProvider",
            "documentSymbolProvider",
        }) do
            client.server_capabilities[capability] = false
        end
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
}
