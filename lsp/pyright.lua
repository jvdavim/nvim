return {
    cmd = { 'pyright-langserver', '--stdio' },
    -- Prevent pyright from automatically attaching to python buffers.
    -- We prefer to use 'ty' as the active Python language server in this
    -- configuration. Keeping the pyright config present allows manual
    -- use if needed, but an empty filetypes list prevents auto-attachment.
    filetypes = {},
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
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
