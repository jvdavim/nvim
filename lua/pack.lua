-- Wraps vim.pack.add() to accept short GitHub repo names (e.g. "folke/snacks.nvim")
-- instead of requiring the full URL. Neovim 0.12+ only.

if type(vim.pack) ~= "table" or type(vim.pack.add) ~= "function" then
    vim.notify("vim.pack.add is not available (requires Neovim 0.12+)", vim.log.levels.ERROR)
    return
end

local builtin_pack_add = vim.pack.add

local function normalize_repo(repo)
    if type(repo) ~= "string" then
        return repo
    end
    if repo:match("://") or repo:match("^git@") then
        return repo
    end
    return "https://github.com/" .. repo .. ".git"
end

local function normalize_spec(spec)
    if type(spec) == "string" then
        return normalize_repo(spec)
    end
    if type(spec) ~= "table" then
        return spec
    end

    if vim.islist(spec) then
        local out = {}
        for i, item in ipairs(spec) do
            out[i] = normalize_spec(item)
        end
        return out
    end

    local out = vim.deepcopy(spec)
    if type(out.src) == "string" then
        out.src = normalize_repo(out.src)
    elseif type(out[1]) == "string" then
        out[1] = normalize_repo(out[1])
    end
    return out
end

vim.pack.add = function(spec)
    return builtin_pack_add(normalize_spec(spec))
end
