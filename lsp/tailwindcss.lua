return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
        "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html",
        "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks",
        "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript",
        "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ"
    },
    root_markers = {
        "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts",
        "postcss.config.js", "postcss.config.cjs", "postcss.config.mjs", "postcss.config.ts", "package.json",
        "node_modules"
    },
    settings = {
        {
            tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                includeLanguages = {
                    eelixir = "html-eex",
                    elixir = "phoenix-heex",
                    eruby = "erb",
                    heex = "phoenix-heex",
                    htmlangular = "html",
                    templ = "html"
                },
                lint = {
                    cssConflict = "warning",
                    invalidApply = "error",
                    invalidConfigPath = "error",
                    invalidScreen = "error",
                    invalidTailwindDirective = "error",
                    invalidVariant = "error",
                    recommendedVariantOrder = "warning"
                },
                validate = true
            }
        }
    },
}
