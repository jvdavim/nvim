local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

return {
    cmd = { mason_bin .. "/kotlin-language-server" },
    filetypes = { "kotlin" },
    root_markers = {
        "settings.gradle",
        "settings.gradle.kts",
        "build.gradle",
        "build.gradle.kts",
        "pom.xml",
        ".git",
    },
    settings = {
        kotlin = {
            compiler = {
                jvm = {
                    target = "17",
                },
            },
        },
    },
}
