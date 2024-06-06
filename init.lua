require("jvdavim")

-- temporary fix on quit ------------------------------------------
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.cmd('!notify-send  "hello"')
        vim.cmd("sleep 10m")
    end,
})
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.fn.jobstart('notify-send "hello"', { detach = true })
    end,
})
vim.cmd("set list listchars+=space:·,eol:↵")
-----------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("jvdavim.plugins")
