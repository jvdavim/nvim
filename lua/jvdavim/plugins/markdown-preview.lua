return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	config = function()
		vim.keymap.set("n", "<leader>s", "<cmd> MarkdownPreview <CR>")
	end,
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
