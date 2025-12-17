--- JDKs
local jdk8_home = os.getenv("ProgramFiles") .. "/Amazon Corretto/jdk1.8.0_422"
local jdk11_home = os.getenv("ProgramFiles") .. "/Amazon Corretto/jdk11.0.24_8"
local jdk17_home = os.getenv("ProgramFiles") .. "/Amazon Corretto/jdk17.0.12_7"
local jdk21_home = os.getenv("ProgramFiles") .. "/Amazon Corretto/jdk21.0.6_7"
local java_home = jdk21_home

--- Eclipse JDT Language Server
local jdtls_home = os.getenv("LOCALAPPDATA") .. "/jdt-language-server-1.45.0-202502271238"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace = vim.fn.expand("~/.jdtls/") .. project_name
local jdtls_java_debug_server_home = os.getenv("LOCALAPPDATA") .. "/java-debug-0.53.1"
local jdtls_java_debug_server_plugin = jdtls_java_debug_server_home
    .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar"

return {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        java_home .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jdtls_home .. "/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar",
        "-configuration",
        jdtls_home .. "/config_win",
        "-data",
        jdtls_workspace,
    },
    root_markers = { ".git", "mvnw", "pom.xml", "gradlew" },
    filetypes = { "java" },
    -- eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = jdk8_home,
                    },
                    {
                        name = "JavaSE-11",
                        path = jdk11_home,
                    },
                    {
                        name = "JavaSE-17",
                        path = jdk17_home,
                    },
                    {
                        name = "JavaSE-21",
                        path = jdk21_home,
                        default = true,
                    },
                },
            },
        },
    },
    -- Language server `initializationOptions`
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    init_options = {
        bundles = {
            jdtls_java_debug_server_plugin,
        },
    },
}
