return {
    cmd = { "pyrefly", "lsp" },
    filetypes = { "python" },
    root_markers = {
        "pyrefly.toml",
        "pyproject.toml",
        "setup.py",
        "mypy.ini",
        "pyrightconfig.json",
        ".git",
    },
    before_init = function(_, config)
        local root_dir = config.root_dir
        if type(root_dir) ~= "string" or root_dir == "" then
            return
        end

        config.init_options = config.init_options or {}
        config.init_options.pyrefly = config.init_options.pyrefly or {}

        local extra_paths = config.init_options.pyrefly.extraPaths or {}
        if not vim.tbl_contains(extra_paths, root_dir) then
            table.insert(extra_paths, root_dir)
        end
        config.init_options.pyrefly.extraPaths = extra_paths
    end,
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
    init_options = {
        pyrefly = {
            analysis = {
                diagnosticMode = "workspace",
            },
        },
    },
}
