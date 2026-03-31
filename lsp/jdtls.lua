local jdtls_home = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local root_markers = { "mvnw", "pom.xml", "gradlew", "build.gradle", "build.gradle.kts", ".git" }
local root_dir = vim.fs.root(0, root_markers) or vim.fn.getcwd()
root_dir = root_dir:gsub("/$", "")

local project_name = vim.fn.fnamemodify(root_dir, ":t")
if project_name == "" then
    project_name = "java-workspace"
end

local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
local truststore = vim.fn.expand("~/.config/java/cacerts")

local cmd_env = {}
if vim.fn.filereadable(truststore) == 1 then
    local truststore_opts = "-Djavax.net.ssl.trustStore=" .. truststore .. " -Djavax.net.ssl.trustStorePassword=changeit"
    cmd_env.MAVEN_OPTS = truststore_opts
    cmd_env.JAVA_TOOL_OPTIONS = truststore_opts
end

local java_home = vim.fn.trim(vim.fn.system("/usr/libexec/java_home -v 21"))
if vim.v.shell_error == 0 and java_home ~= "" then
    cmd_env.JAVA_HOME = java_home
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
    capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
end

return {
    root_dir = root_dir,
    cmd_env = cmd_env,
    cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. jdtls_home .. "/lombok.jar",
        "--jvm-arg=-Dlog.protocol=true",
        "--jvm-arg=-Dlog.level=WARN",
        "-data",
        workspace_dir,
    },
    filetypes = { "java" },
    root_markers = root_markers,
    capabilities = capabilities,
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = "automatic",
            },
            maven = {
                downloadSources = true,
            },
            eclipse = {
                downloadSources = true,
            },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            contentProvider = { preferred = "fernflower" },
        },
    },
}
