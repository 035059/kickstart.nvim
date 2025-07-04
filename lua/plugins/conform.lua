--[[ Autoformat ]]
return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 1500,
			lsp_fallback = false,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "isort", "black" },
			tex = { "llf" },
		},
	},
}
