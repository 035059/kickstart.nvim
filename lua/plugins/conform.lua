--[[ Autoformat ]]
return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
<<<<<<< HEAD
			timeout_ms = 1500,
			lsp_fallback = false,
=======
			timeout_ms = 750,
			lsp_fallback = true,
>>>>>>> 85793ab79bf8fd338ba999a1a18baccb0b669d5b
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			python = { "isort", "black" },
			tex = { "llf" },
		},
	},
}
