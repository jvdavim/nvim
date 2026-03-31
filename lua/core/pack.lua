-- Minimal plugin loader using Neovim builtin vim.pack (Neovim 0.12+)
-- This replaces lazy.nvim. It does not implement lazy-loading features.

local M = {}
-- keep reference to Neovim's builtin pack.add before we override it
local builtin_pack_add = vim.pack.add

-- Minimal pack manager that clones plugins into stdpath('data')/site/pack/plugins/start
-- Works with calls like: vim.pack.add("user/repo") or vim.pack.add({"user/repo"})

local function repo_to_name(repo)
    if type(repo) == "table" then
        repo = repo[1]
    end
    if type(repo) ~= "string" then
        return nil
    end
    local name = repo:match(".*/(.+)$") or repo
    return name:gsub("%.git$", "")
end

local function is_installed_name(name)
    if not name or name == "" then
        return false
    end
    local data = vim.fn.stdpath("data")
    local start_path = data .. "/site/pack/plugins/start/" .. name
    local opt_path = data .. "/site/pack/plugins/opt/" .. name
    if vim.loop.fs_stat(start_path) or vim.loop.fs_stat(opt_path) then
        return true
    end
    return false
end

-- We use Neovim builtin `vim.pack.add` (captured as builtin_pack_add) to perform clone/install.
-- No manual git cloning in this loader to keep behavior consistent with the official API.

-- Replace vim.pack.add with a clone-if-missing implementation
vim.pack.add = function(item)
    local repo = nil
    if type(item) == "table" then
        repo = item[1]
    else
        repo = item
    end
    if type(repo) ~= "string" then
        return
    end
    local name = repo_to_name(repo)
    if is_installed_name(name) then
        -- already installed: ensure it's loaded
        pcall(vim.cmd, "packadd " .. name)
        return
    end
    -- prefer passing URL to builtin pack.add so Neovim handles cloning
    local url = repo
    if not url:match("://") and not url:match("^git@") then
        url = "https://github.com/" .. url .. ".git"
    end
    builtin_pack_add({ url })
    pcall(vim.cmd, "packadd " .. name)
end

local config_path = vim.fn.stdpath("config")
local plugin_glob = config_path .. "/lua/plugins/*.lua"
local files = vim.fn.glob(plugin_glob, false, true)

for _, path in ipairs(files) do
    -- convert path to module name, e.g. lua/plugins/foo.lua -> plugins.foo
    local mod = path:match(config_path .. "/lua/(.+)%.lua$")
    if mod then
        local ok, spec = pcall(require, mod)
        if ok and spec then
            -- If module returned a table spec (lazy-style), try to handle it
            if type(spec) == "table" and type(spec[1]) == "string" then
                -- run init if present (init is meant to run before loading)
                if type(spec.init) == "function" then
                    pcall(spec.init)
                end

                -- add dependencies first (best-effort)
                local function add_dep(d)
                    if type(d) == "string" then
                        local n = repo_to_name(d)
                        local t = vim.fn.stdpath("data") .. "/site/pack/plugins/start/" .. n
                        if not is_installed_name(n) then
                            local url = d
                            if not url:match("://") and not url:match("^git@") then
                                url = "https://github.com/" .. url .. ".git"
                            end
                            builtin_pack_add({ url })
                        end
                        pcall(vim.cmd, "packadd " .. n)
                    elseif type(d) == "table" then
                        for _, v in ipairs(d) do
                            if type(v) == "string" then
                                local n = repo_to_name(v)
                                local t = vim.fn.stdpath("data") .. "/site/pack/plugins/start/" .. n
                                if not is_installed_name(n) then
                                    local url = v
                                    if not url:match("://") and not url:match("^git@") then
                                        url = "https://github.com/" .. url .. ".git"
                                    end
                                    builtin_pack_add({ url })
                                end
                                pcall(vim.cmd, "packadd " .. n)
                            end
                        end
                    end
                end

                if spec.dependencies then
                    add_dep(spec.dependencies)
                end

                local repo = spec[1]
                local name = repo_to_name(repo)
                local is_lazy = spec.lazy == true or spec.event or spec.ft or spec.cmd
                local target = vim.fn.stdpath("data") .. "/site/pack/plugins/" .. (is_lazy and "opt" or "start") .. "/" .. name

                if not is_installed_name(name) then
                    local url = repo
                    if not url:match("://") and not url:match("^git@") then
                        url = "https://github.com/" .. url .. ".git"
                    end
                    builtin_pack_add({ url })
                end

                if is_lazy then
                    -- For lazy plugins, set up autoload triggers
                    -- Cmds
                    if spec.cmd then
                        local cmds = spec.cmd
                        if type(cmds) == "string" then
                            cmds = { cmds }
                        end
                        for _, c in ipairs(cmds) do
                            pcall(vim.api.nvim_create_user_command, c, function(opts)
                                pcall(vim.cmd, "packadd " .. name)
                                pcall(vim.cmd, c .. (opts.args ~= "" and " " .. opts.args or ""))
                            end, { nargs = "*" })
                        end
                    end

                    -- Filetypes
                    if spec.ft then
                        local fts = spec.ft
                        if type(fts) == "string" then
                            fts = { fts }
                        end
                        pcall(vim.api.nvim_create_augroup, "pack_ft_" .. name, { clear = true })
                        for _, ft in ipairs(fts) do
                            pcall(vim.api.nvim_create_autocmd, "FileType", {
                                pattern = ft,
                                group = "pack_ft_" .. name,
                                callback = function()
                                    pcall(vim.cmd, "packadd " .. name)
                                end,
                                once = true,
                            })
                        end
                    end

                    -- Events
                    if spec.event then
                        local ev = spec.event
                        if type(ev) == "string" then
                            ev = { ev }
                        end
                        pcall(vim.api.nvim_create_augroup, "pack_ev_" .. name, { clear = true })
                        for _, e in ipairs(ev) do
                            pcall(vim.api.nvim_create_autocmd, e, {
                                group = "pack_ev_" .. name,
                                callback = function()
                                    pcall(vim.cmd, "packadd " .. name)
                                end,
                                once = true,
                            })
                        end
                    end

                    -- Keys: create lazy-mapping wrappers that packadd on first use
                    if spec.keys then
                        for _, k in ipairs(spec.keys) do
                            local lhs = k[1]
                            local rhs = k[2]
                            local opts = k.opts or k[3] or {}
                            vim.keymap.set("n", lhs, function()
                                pcall(vim.cmd, "packadd " .. name)
                                -- execute mapped rhs after loading
                                if type(rhs) == "string" then
                                    pcall(vim.cmd, rhs)
                                elseif type(rhs) == "function" then
                                    pcall(rhs)
                                end
                            end, opts)
                        end
                    end
                else
                    -- non-lazy: load and run config
                    pcall(vim.cmd, "packadd " .. name)
                    if type(spec.config) == "function" then
                        pcall(spec.config)
                    end
                end
            elseif type(spec) == "string" then
                -- module returned a simple string repo; install into start
                local repo = spec
                local name = repo_to_name(repo)
                local target = vim.fn.stdpath("data") .. "/site/pack/plugins/start/" .. name
                if not is_installed_name(name) then
                    local url = repo
                    if not url:match("://") and not url:match("^git@") then
                        url = "https://github.com/" .. url .. ".git"
                    end
                    builtin_pack_add({ url })
                end
                pcall(vim.cmd, "packadd " .. name)
            else
                -- some plugin modules (like color schemes) may call vim.pack.add themselves
                -- requiring them is sufficient; nothing else to do here
            end
        end
    end
end

return M
