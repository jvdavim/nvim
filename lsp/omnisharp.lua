local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

return {
    cmd = { mason_bin .. "/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    filetypes = { "cs", "vb" },
    root_markers = { "*.sln", "*.csproj", ".git" },
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
        },
        RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
        },
        MsBuild = {
            LoadProjectsOnDemand = false,
        },
    },
}
