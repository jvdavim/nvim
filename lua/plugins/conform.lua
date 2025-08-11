return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fw",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format file or range (in visual mode)",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
			typescript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			svelte = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			htmlangular = { "prettierd", "prettier", stop_after_first = true },
			json = { "jq", "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			graphql = { "prettierd", "prettier", stop_after_first = true },
			csharp = { "dotnet-csharpier" },
			lua = { "stylua" },
			python = { "ruff_format" },
			go = { "gofmt", "gofumpt", stop_after_first = true },
			bash = { "shfmt" },
			sh = { "shfmt" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = false,
		log_level = vim.log.levels.DEBUG,
	},
}
