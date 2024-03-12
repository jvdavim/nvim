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
