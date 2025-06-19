return {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "tmpl" },
    root_markers = { "package.json", ".git" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
}
