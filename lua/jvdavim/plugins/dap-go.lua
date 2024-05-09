return {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dap-go").setup({
			dap_configurations = {
				{
					-- Must be "go" or it will be ignored by the plugin
					type = "go",
					name = "Attach remote",
					mode = "remote",
					request = "attach",
				},
			},
			delve = {
				path = "dlv",
			},
		})
	end,
}
