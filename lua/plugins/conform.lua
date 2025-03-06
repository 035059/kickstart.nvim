--[[ Autoformat ]]
return {
<<<<<<< HEAD
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			-- Conform can also run multiple formatters sequentially
			python = { "isort", "black" },
		},
	},
=======
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { " rustfmt " },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
>>>>>>> 1a64de64906ad9b19d0dcf4e75d2e4bdfe60b8a5
}
